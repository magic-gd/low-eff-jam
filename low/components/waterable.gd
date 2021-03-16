extends Node

signal fully_watered
signal water_change(water)

export (NodePath) onready var body = get_node(body) if body else get_parent() #wow

export (float) var max_water = 100
export (float) var water = 0 setget set_water
export (float) var dry_speed = 1
export (float) var grow_ratio = 1

export (bool) var destroy_when_done = false
export (bool) var disable_when_done = false

var initial_scale
var drying = true

func _ready():
	initial_scale = body.scale
#	self.connect("water_change", self, "grow")
	$DryTick.connect("timeout", self, "dry")
	$DryWait.connect("timeout", self, "_start_drying")
	if dry_speed == 0:
		$DryTick.stop()
	grow()

func set_water(p_water):
	if p_water != water:
		water = p_water
		emit_signal("water_change", water)

func water():
	drying = false
	if $DryWait.is_stopped():
		$DryWait.start()
	
	if water <= max_water:
		set_water(min(max_water, water + 1))
		grow()
		if water == max_water:
			done()

func done():
	emit_signal("fully_watered")
	if disable_when_done:
		body.get_node("CollisionShape2D").call_deferred("set_disabled", true)
	if destroy_when_done:
		if body.has_method("destroy"):
			body.destroy()
		else:
			body.queue_free()

func dry():
	if not drying:
		return
	
	set_water(max(0, water - dry_speed))
	grow()

func grow():
	var water_fill: float = float(water) / float(max_water)
	var new_scale_x = initial_scale.x * (1 + (grow_ratio * water_fill))
	var new_scale_y = initial_scale.y * (1 + (grow_ratio * water_fill))
	body.scale = Vector2(new_scale_x, new_scale_y)

func _start_drying():
	drying = true
