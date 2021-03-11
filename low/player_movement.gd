extends Node

var body

func _ready():
	body = get_parent()
	pass

func _physics_process(delta):
	if Input.is_action_pressed("lauf_links"):
		body.applied_force = Vector2(-1000, 0)
	elif Input.is_action_pressed("lauf_recht"):
		body.applied_force = Vector2(1000, 0)
	else:
		body.applied_force = Vector2(0, 0)

func _input(event):
	if event.is_action_pressed("spring"):
		jump()

func jump():
	body.apply_central_impulse(Vector2(0, -500))
	pass
