extends Node

export (Array, NodePath) var flip_on_turn = []
export (NodePath) var sprite_path

export (float) var speed = 150
export (float) var gravity = 100
export (float) var jump_height = 600

onready var body: KinematicBody2D = get_parent()

var look_dir = 1 setget set_look_dir
var last_movement: Vector2
var jump = false

func _ready():
	$TurnTimer.connect("timeout", self, "turn_around")

func _input(event):
	if not body.is_in_group("player"):
		return
	
	if event.is_action_pressed("jump"):
		jump = true

func _physics_process(delta):
	var movement = Vector2(0, gravity)
	
	if body.is_in_group("player"):
		movement = _player_move(delta)
	else:
		movement = _auto_move(delta)
	
	if jump:
		movement.y = -jump_height
		jump = false
	
	last_movement = body.move_and_slide(movement, Vector2(0, -1), false, 4, 0.785398, false)

func _process(delta):
	# Stop animation when not moving
	get_node(sprite_path).playing = last_movement.length() > 0.5

func _player_move(delta) -> Vector2:
	if Input.is_action_pressed("move_left"):
		set_look_dir(-1)
		return Vector2(-speed, last_movement.y + gravity)
	elif Input.is_action_pressed("move_right"):
		set_look_dir(1)
		return Vector2(speed, last_movement.y + gravity)
	else:
		return Vector2(0, last_movement.y + gravity)

func _auto_move(delta) -> Vector2:
	for i in body.get_slide_count():
		var collision = body.get_slide_collision(i)
		if collision.collider.is_in_group("player"):
			#Dont move if layer is touching
			return Vector2(delta * look_dir, last_movement.y + gravity)
	
	if(body.is_on_wall() and $TurnTimer.is_stopped()):
		$TurnTimer.start()
	
	return Vector2(speed * look_dir, last_movement.y + gravity)


func set_look_dir(dir: int): # dir: -1 or 1
	look_dir = dir
	if flip_on_turn.empty():
		return
	
	for node_path in flip_on_turn:
		var node = get_node(node_path)
		node.scale.x *= -dir if node.scale.x < 0 else dir

func turn_around():
	if body.is_on_wall():
		set_look_dir(look_dir * -1)
