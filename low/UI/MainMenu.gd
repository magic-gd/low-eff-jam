extends Control

func _ready():
	$Panel/PlayButton.connect("pressed", self, "start_game")
	$Panel2/CreditsButton.connect("pressed", self, "show_credits")

func start_game():
	get_tree().change_scene("res://levels/Level_Intro.tscn")

func show_credits():
	get_tree().change_scene("res://UI/Credits.tscn")
