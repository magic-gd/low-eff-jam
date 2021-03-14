extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active_texture = preload("res://fjr/tex/button_active.png")
var inactive_texture = preload("res://fjr/tex/button_inactive.png")
signal pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	deactivate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
# pass

func activate():
	emit_signal("pressed")
	get_node("ButtonTex").texture = active_texture
	
func deactivate():
	get_node("ButtonTex").texture = inactive_texture


func _on_Collider_body_entered(body):
	if(body.name == "Player"):
		activate()
