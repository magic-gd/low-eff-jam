extends Area2D

export (Vector2) var move_vector
export var fall_speed = 10.0
export var fall_accel = 9.8

const max_fall_speed = 200

func _ready():
	$DespawnTimer.connect("timeout", self, "despawn")
	connect("body_entered", self, "moisten_object")
	linear_damp = 0.05

func _physics_process(delta):
	global_position = global_position + move_vector + Vector2(0, fall_speed) * 10 * delta
	move_vector = move_vector * (1-linear_damp)
	fall_speed = min(fall_speed + fall_accel, max_fall_speed)
	print(fall_speed)

func setup(p_move_vector, p_fall_speed):
	move_vector = p_move_vector
	fall_speed = p_fall_speed

func moisten_object(body: Node):
	if body and body.get_node("waterable"):
		body.get_node("waterable").water()
	despawn()

func despawn():
	queue_free()
