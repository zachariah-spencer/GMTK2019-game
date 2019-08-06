extends Projectile


var max_speed = 700
var accel := 900

func _ready():
	speed = max_speed
	draw_orb = false

func _physics_process(delta):
#	accel += 100

	speed -= accel * delta
	speed = max(speed, 0)

func fizzle():
	if $FizzleTimer.is_stopped() :
		$CPUParticles2D.emitting = false
		set_deferred("monitoring", false)
		$FizzleTimer.start()

func _draw():
	return
