extends Projectile

var max_speed = 700
var accel := 200

func _physics_process(delta):
	accel += 100
	speed += accel * delta
	
	speed = min(speed, max_speed)