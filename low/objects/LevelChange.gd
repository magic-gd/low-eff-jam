extends Area2D

export (PackedScene) var next_level

func _ready():
	connect("body_entered", self, "_on_body_entered")

func switch_level():
	get_tree().change_scene_to(next_level)

func _on_body_entered(body):
	if body.is_in_group("player"):
		switch_level()
