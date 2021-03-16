extends Position2D

signal water_change(water)

export (NodePath) onready var body = get_node(body)

export (Resource) var water_particle = preload("res://objects/WaterParticle.tscn")
export (float) var spray_speed = 20

export (float) var water = 500 setget set_water
export (float) var max_water = 500

onready var progress_bar = $CanvasLayer/TextureProgress

var spraying = false

func _process(delta):
	if body.is_in_group("player"):
		progress_bar.value = water
		progress_bar.visible = true
	else:
		progress_bar.visible = false

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	progress_bar.max_value = max_water
	progress_bar.value = water

func _input(event):
	if not body.is_in_group("player"):
		spraying = false
		return
	
	if event.is_action_pressed("spray"):
		spraying = true
	elif event.is_action_released("spray"):
		spraying = false

func set_water(p_water):
	if p_water != water:
		water = p_water
		emit_signal("water_change", water)

func refill(amount: float):
	set_water(min(max_water, water + amount))
	if amount > 0 and water < max_water and not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()

func _on_Timer_timeout():
	if not spraying or water <= 0:
		return
	
	var particle = water_particle.instance()
	var spray_direction: Vector2 = global_position.direction_to($Target.global_position)
	particle.setup(Vector2(spray_direction * _randomize_speed(spray_speed, 0.1)), 5.0)
	particle.global_position = global_position
	body.get_parent().add_child(particle)
	
	set_water(max(0, water - 1))

func _randomize_speed(speed, percent_amount):
	return speed * rand_range(1-percent_amount, 1+percent_amount)
