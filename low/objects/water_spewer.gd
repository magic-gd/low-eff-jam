extends Position2D

export (Resource) var water_particle = preload("res://objects/WaterParticle.tscn")
export (Vector2) var direction = Vector2(1, 0)

var spraying = false

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func _input(event):
	if event.is_action_pressed("spray"):
		spraying = true
	elif event.is_action_released("spray"):
		spraying = false

func _on_Timer_timeout():
	if not spraying:
		return
	
	var particle = water_particle.instance()
	particle.setup(Vector2(10, 0), 10.0)
	particle.global_position = global_position
	get_parent().get_parent().add_child(particle)
