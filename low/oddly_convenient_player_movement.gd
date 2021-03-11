extends Node

onready var body: RigidBody2D = get_parent()

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		body.applied_force = Vector2(-1000, 0)
	elif Input.is_action_pressed("move_right"):
		body.applied_force = Vector2(1000, 0)
	else:
		body.applied_force = Vector2(0, 0)

func _input(event):
	if event.is_action_pressed("jump"):
		jump()

func jump():
	body.apply_central_impulse(Vector2(0, -500))
