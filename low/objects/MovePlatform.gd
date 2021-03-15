extends KinematicBody2D

export (Vector2) var direction
export (float) var distance

var current_distance = 0
var dir = 1
var velocity = Vector2(0, 0)

func _physics_process(delta):
	velocity = direction * dir
	current_distance += velocity.length()
	if current_distance >= distance:
		# Reverse direction
		dir *= -1
		current_distance = 0
	
	velocity = move_and_slide_with_snap(velocity, Vector2(0, -1))
