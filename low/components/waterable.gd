extends Node

signal fully_watered

export (int) var max_water = 100
export (int) var water = 0

export (float) var grow_ratio = 1

export (bool) var destroy_when_done = false

func _ready():
	grow()

func water():
	if water <= max_water:
		water += 1
		grow()
		if water == max_water:
			emit_signal("fully_watered")
			if destroy_when_done:
				get_parent().queue_free()

func grow():
	var water_fill: float = float(water) / float(max_water)
	var new_scale = 1 + (grow_ratio * water_fill)
	get_parent().scale = Vector2(new_scale, new_scale)
