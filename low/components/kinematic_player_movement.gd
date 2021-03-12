extends Node

export (NodePath) var sprite_path

onready var body: KinematicBody2D = get_parent()


func _physics_process(delta):
	if not body.is_in_group("player"):
		return
	
	if Input.is_action_pressed("move_left"):
		body.move_and_slide(Vector2(-100, 10), Vector2(0,-1))
		get_node(sprite_path).flip_h = true
	elif Input.is_action_pressed("move_right"):
		body.move_and_slide(Vector2(100, 10), Vector2(0,-1))
		get_node(sprite_path).flip_h = false
	else:
		body.move_and_slide(Vector2(0, 10), Vector2(0,-1))
