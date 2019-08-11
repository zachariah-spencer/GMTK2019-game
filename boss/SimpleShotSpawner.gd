extends ProjectileSpawner

func _fire() :
	if projectiles_to_fire > 0 :
		_add_projectile((player.global_position - global_position).normalized(), projectile, offset)
		projectiles_to_fire -= 1
		$DelayTimer.start(projectile_space)
