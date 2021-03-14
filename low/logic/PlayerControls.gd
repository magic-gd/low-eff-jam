extends Node

func _ready():
	var player = get_tree().get_nodes_in_group("player")[0]
	if player:
		player.get_node("Camera2D").current = true

func _input(event):
	if event.is_action_pressed("interact"):
		var player = get_tree().get_nodes_in_group("player")[0]
		var area: Area2D = player.find_node("InteractionArea")
		var body_found = false
		for nearby_body in area.get_overlapping_bodies():
			if nearby_body != player and nearby_body.is_in_group("controllable"):
				body_found = true
				swap_player(player, nearby_body)
				break
		if not body_found and not player.name == "Ghost":
			var ghost = preload("res://Ghost.tscn").instance()
			ghost.global_position = player.global_position
			player.get_parent().add_child(ghost)
			swap_player(player, ghost)

func swap_player(old_body, new_body):
	new_body.add_to_group("player")
	new_body.get_node("Camera2D").current = true
	old_body.remove_from_group("player")
