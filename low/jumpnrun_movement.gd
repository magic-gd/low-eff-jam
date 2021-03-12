extends Node

export (NodePath) var sprite_path

onready var body: RigidBody2D = get_parent()

func _ready():
	pass

func _physics_process(delta):
	if not body.is_in_group("player"):
		return
	
	if Input.is_action_pressed("move_left"):
		body.applied_force = Vector2(-1000, 0)
		get_node(sprite_path).flip_h = true
	elif Input.is_action_pressed("move_right"):
		body.applied_force = Vector2(1000, 0)
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
	if body.linear_velocity.y > -600:
		body.apply_central_impulse(Vector2(0, -600))
	pass

func cap_speed():
	if abs(body.linear_velocity.x) > 1000:
		body.applied_force = Vector2(0, 0)
