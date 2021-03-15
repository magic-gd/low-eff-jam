extends Node2D

var shrinking = false


func _process(delta):
	if(shrinking):
		scale.y -= delta
		
		if(scale.y < 1):
			shrinking = false
			scale.y = 1

func _on_Button_pressed():
	shrinking = true
	
