extends KinematicBody2D

var dir = 1;

func _physics_process(delta):
	if is_in_group("player"):
		return
	
	move_and_slide(Vector2(100*dir,100),Vector2(0,-1))
	if(is_on_wall()):
		dir *= -1
#		transform = Transform2D(transform.x * -1, transform.y, transform.origin)
		$AnimatedSprite.flip_h = true if dir == -1 else false
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if not(collision.collider is TileMap):
			print("I collided with ", collision.collider.name)

