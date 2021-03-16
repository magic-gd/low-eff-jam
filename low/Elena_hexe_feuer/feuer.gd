extends StaticBody2D

export (float) var max_water = 200
export (float) var water = 100
export (float) var dry_speed = 0.1
export (float) var grow_ratio = -0.8

func _ready():
	$waterable.max_water = max_water
	$waterable.water = water
	$waterable.dry_speed = dry_speed
	$waterable.grow_ratio = grow_ratio
