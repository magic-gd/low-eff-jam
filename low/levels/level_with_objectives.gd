extends "res://levels/level.gd"

onready var objectives = $Objectives

var objectives_left
var done = false

func _ready():
	$ObjectiveTimer.connect("timeout", self, "_check_objectives")
	objectives_left = objectives.get_child_count()
	$UILayer/UI/MissionLabel.text = "- Put out all the fires! (" + str(objectives_left) + ") "

func _check_objectives():
	if done:
		return
	
	if objectives.get_child_count() < objectives_left:
		objectives_left = objectives.get_child_count()
		$UILayer/UI/MissionLabel.text = "- Put out all the fires! (" + str(objectives_left) + ") "
		MusicController.play_effect("complete")
	
	if objectives_left == 0:
		done = true
		_objectives_complete()

func _objectives_complete():
	$UILayer/UI/MissionLabel.text = ""
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().change_scene("res://levels/Ending_Cutscene.tscn")
	pass
