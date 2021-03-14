extends RigidBody2D

func _process(delta):
	if not is_in_group("player"):
		queue_free()
