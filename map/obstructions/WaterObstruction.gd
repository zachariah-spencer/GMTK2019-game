extends Obstruction

func activate():
	$Area2D.collision_layer = 0
	$Area2D.collision_mask = 0
	$DestroySound.play()
	$CPUParticles2D.emitting = false

