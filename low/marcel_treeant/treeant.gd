extends KinematicBody2D

# Treeant synchs water between waterable (size) and water sprayer

onready var waterable = $waterable
onready var water_sprayer = $flip_on_turn/WaterSprayer

func _ready():
	waterable.connect("water_change", self, "synch_water_sprayer")
	water_sprayer.connect("water_change", self, "synch_waterable")
	synch_water_sprayer(waterable.water)
	pass

func synch_water_sprayer(water):
	water_sprayer.set_water(water)

func synch_waterable(water):
	waterable.set_water(water)
