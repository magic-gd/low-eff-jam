extends Node

func _input(event):
	if event.is_action_pressed("interact"):
		var player = get_tree().get_nodes_in_group("player")[0]
		var area: Area2D = player.find_node("InteractionArea")
		for nearby_body in area.get_overlapping_bodies():
			if nearby_body != player and nearby_body.is_in_group("controllable"):
				swap_player(player, nearby_body)
				break

func swap_player(old_body, new_body):
	new_body.add_to_group("player")
	new_body.get_node("Camera2D").current = true
	old_body.remove_from_group("player")
