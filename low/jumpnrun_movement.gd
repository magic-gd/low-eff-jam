extends Node

export (NodePath) var sprite_path

export (float) var speed = 1000
export (float) var jump_height = 600

onready var body: RigidBody2D = get_parent()

func _ready():
	pass

func _physics_process(delta):
	if not body.is_in_group("player"):
		return
	
	if Input.is_action_pressed("move_left"):
		body.applied_force = Vector2(-speed, 0)
		get_node(sprite_path).flip_h = true
	elif Input.is_action_pressed("move_right"):
		body.applied_force = Vector2(speed, 0)
		get_node(sprite_path).flip_h = false
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

func cap_speed():
	if abs(body.linear_velocity.x) > speed:
		body.applied_force = Vector2(0, 0)
