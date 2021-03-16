extends Node2D

func _ready():
	MusicController.play_song("happy")
	$CanvasLayer/UI/Panel/Button.connect("pressed", self, "_on_menu_button_pressed")

func _on_menu_button_pressed():
	get_tree().change_scene("res://UI/MainMenu.tscn")
