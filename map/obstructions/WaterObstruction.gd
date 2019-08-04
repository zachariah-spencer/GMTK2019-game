extends Obstruction

func activate():
	$FizzleTimer.start()
	$Body.collision_layer = 0
	$Body.collision_mask = 0
	$DestroySound.play()

func _physics_process(delta):
	if not $FizzleTimer.is_stopped() :
		$Sprite.material.set_shader_param("alpha_cull", $FizzleTimer.time_left)
