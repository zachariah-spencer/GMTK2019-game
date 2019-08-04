extends Projectile

var central_orbit : Vector2
var velocity := Vector2.ZERO

func _move(delta):
	velocity = (central_orbit - position).rotated(PI/1.95) * speed
	move_local_x(velocity.x * delta)
	move_local_y(velocity.y * delta)