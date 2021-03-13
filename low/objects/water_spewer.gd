extends Position2D

export (NodePath) onready var body = get_node(body)

export (Resource) var water_particle = preload("res://objects/WaterParticle.tscn")
export (float) var spray_speed = 20

var spraying = false

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func _input(event):
	if not body.is_in_group("player"):
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
	var spray_direction: Vector2 = global_position.direction_to($Target.global_position)
	particle.setup(Vector2(spray_direction * spray_speed), 5.0)
	particle.global_position = global_position
	body.get_parent().add_child(particle)
