extends Node

export (Array, NodePath) var flip_on_turn = []

export (float) var acceleration = 1000
export (float) var max_speed = 500
export (float) var max_fall_speed = 2000
export (float) var jump_height = 600

onready var body: RigidBody2D = get_parent()

func _ready():
	pass

func _physics_process(delta):
	if not body.is_in_group("player"):
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

func _input(event):
	if not body.is_in_group("player"):
		return
	
	if event.is_action_pressed("jump"):
		jump()

func jump():
	if body.linear_velocity.y > -jump_height:
		body.apply_central_impulse(Vector2(0, -jump_height))
	pass

func set_look_dir(dir: int): # dir: -1 or 1
	if flip_on_turn.empty():
		return
	
	for node_path in flip_on_turn:
		var node = get_node(node_path)
		node.scale.x *= dir if node.scale.x < 0 else -dir

func cap_speed():
	body.linear_velocity.x = clamp(body.linear_velocity.x, -max_speed, max_speed)
	body.linear_velocity.y = clamp(body.linear_velocity.y, -max_fall_speed, max_fall_speed)
