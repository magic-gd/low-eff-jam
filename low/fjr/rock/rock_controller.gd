extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shrinking = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(shrinking):
		get_node(".").scale.y -= delta
		
		if(get_node(".").scale.y < 1):
			shrinking = false
			get_node(".").scale.y = 1

func _on_Button_pressed():
	shrinking = true
	
