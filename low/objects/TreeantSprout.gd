extends StaticBody2D
var destroyed = false

func _ready():
	PlayerControls.connect("player_change", self, "_on_player_change")
	_on_player_change()

func destroy():
	if destroyed:
		return
	
	destroyed = true
	var treeant = preload("res://marcel_treeant/treeant.tscn").instance()
	treeant.global_position = global_position + Vector2(0, -14)
	get_parent().add_child(treeant)
	queue_free()

func _on_player_change():
	if is_in_group("player"):
		$UILayer/UI.visible = true
	else:
		$UILayer/UI.visible = false
