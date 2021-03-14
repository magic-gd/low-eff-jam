tool
extends StaticBody2D

export (Color) var color = Color(1, 1, 1)

func _ready():
	$Flower.modulate = color
