extends Obstruction

func activate():
	$FizzleTimer.start()
	$DestroySound.play()
	$Body.collision_layer = 0
	$Body.collision_mask = 0


func _physics_process(delta):
	if not $FizzleTimer.is_stopped() :
		$Sprite.material.set_shader_param("alpha_cull", $FizzleTimer.time_left)
