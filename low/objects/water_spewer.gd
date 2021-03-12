extends Position2D

export (Resource) var water_particle = preload("res://objects/WaterParticle.tscn")
export (Vector2) var spray_direction = Vector2(10, 0)

var spraying = false

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func _input(event):
	if not get_parent().is_in_group("player"):
		spraying = false
		return
	
	if event.is_action_pressed("spray"):
		spraying = true
	elif event.is_action_released("spray"):
		spraying = false

func _on_Timer_timeout():
	if not spraying:
		return
	
	var particle = water_particle.instance()
	particle.setup(spray_direction, 5.0)
	particle.global_position = global_position
	get_parent().get_parent().add_child(particle)
