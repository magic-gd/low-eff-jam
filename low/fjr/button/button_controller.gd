extends Node

var active_texture = preload("res://fjr/tex/button_active.png")
var inactive_texture = preload("res://fjr/tex/button_inactive.png")
signal pressed

func _ready():
	connect("body_entered", self, "_on_body_entered")
	deactivate()
	

func activate():
	emit_signal("pressed")
	get_node("ButtonTex").texture = active_texture
	
func deactivate():
	get_node("ButtonTex").texture = inactive_texture


func _on_body_entered(body):
	if(body.is_in_group("player")):
		activate()
