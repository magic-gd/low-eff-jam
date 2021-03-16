extends "res://levels/level.gd"

onready var objectives = $Objectives

var done = false

func _ready():
	$ObjectiveTimer.connect("timeout", self, "_check_objectives")

func _check_objectives():
	if not done and objectives.get_child_count() == 0:
		done = true
		_objectives_complete()

func _objectives_complete():
	$UILayer/UI/MissionLabel.text = "- Find the exit"
	MusicController.play_effect("complete")
	$Objects/Rock.shrinking = true
	pass
