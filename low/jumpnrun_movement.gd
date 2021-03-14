extends Node

export (Array, NodePath) var flip_on_turn = []

export (float) var acceleration = 1000
export (float) var max_speed = 500
export (float) var max_fall_speed = 2000
export (float) var jump_height = 600
export (int) var jumps = 2 # -1 == infinite

onready var body: RigidBody2D = get_parent()
onready var remaining_jumps = jumps
onready var feet: Array = $Feet.get_children()

func _ready():
	for foot in feet:
		foot.enabled = true
	
	$SaveTimer.connect("timeout", self, "save_from_stuck")

func _physics_process(delta):
	if not body.is_in_group("player"):
		body.applied_force = Vector2(0, 0)
		return
	
	if Input.is_action_pressed("move_left"):
		body.applied_force = Vector2(-acceleration, 0)
		set_look_dir(1)
	elif Input.is_action_pressed("move_right"):
		body.applied_force = Vector2(acceleration, 0)
		set_look_dir(-1)
	else:
		body.applied_force = Vector2(0, 0)
	
	cap_speed()
	check_stuck()

func _input(event):
	if not body.is_in_group("player"):
		return
	
	if event.is_action_pressed("jump"):
		jump()

func jump():
	if _is_on_ground():
		remaining_jumps = jumps
	elif remaining_jumps == 0:
		return
	
	body.apply_central_impulse(Vector2(0, -jump_height))
	remaining_jumps -= 1
	
	if body.linear_velocity.y > -jump_height:
		body.linear_velocity.y = -jump_height

func set_look_dir(dir: int): # dir: -1 or 1
	if flip_on_turn.empty():
		return
	
	for node_path in flip_on_turn:
		var node = get_node(node_path)
		node.scale.x *= dir if node.scale.x < 0 else -dir

func cap_speed():
	body.linear_velocity.x = clamp(body.linear_velocity.x, -max_speed, max_speed)
	body.linear_velocity.y = clamp(body.linear_velocity.y, -max_fall_speed, max_fall_speed)

func _is_on_ground() -> bool:
	for foot in feet:
		if foot.is_colliding():
			return true
	
	return false

func check_stuck():
	if remaining_jumps == 0 and not _is_on_ground() and body.linear_velocity.length() < 0.01:
		if $SaveTimer.is_stopped():
			$SaveTimer.start()
	elif not $SaveTimer.is_stopped():
		$SaveTimer.stop()

func save_from_stuck():
	if body.linear_velocity.length() < 0.01:
		print("stuck saved")
		remaining_jumps = jumps
