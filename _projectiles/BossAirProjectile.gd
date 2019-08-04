extends Projectile

var max_speed = 500
var accel := 200

func _physics_process(delta):
	accel += 50
	speed += accel * delta
	
	speed = min(speed, max_speed)