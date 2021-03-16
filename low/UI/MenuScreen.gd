extends Control

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("menu"):
		visible = !visible

func main_menu():
	get_tree().change_scene("res://UI/MainMenu.tscn")
