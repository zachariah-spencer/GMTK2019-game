extends Area2D



func stop():
	$Particles2D.emitting = false
	monitoring = false



func start():
	$Particles2D.emitting = true
	monitoring = true
	$ActiveTimer.start()


func _physics_process(delta):
	if monitoring :
		for body in get_overlapping_bodies() :
			if body is Player :
				body.velocity.y = -500
			elif body.is_in_group("boss") :
				body.get_parent().velocity.y = -500


func activate():
	$FrequencyTimer.start()
	start()
