extends Area2D

export (float) var refill_speed = 3

func _process(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("player") or body.is_in_group("waterable"):
			var sprayer = body.find_node("WaterSprayer")
			if not sprayer:
				return
			sprayer.refill(refill_speed)
