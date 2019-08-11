extends ProjectileSpawner

func _fire() :
	if projectiles_to_fire > 0 :
		_add_projectile((player.global_position - global_position).normalized(), projectile, offset)
		projectiles_to_fire -= 1
		$DelayTimer.start(projectile_space)

func _add_projectile(direction, proj := projectile, off := offset, t := type):
	var to_add = proj.instance()
	to_add.speed = speed
	to_add.type = t
	to_add.direction = direction.rotated(rand_range(-PI/4,PI/4))
	to_add.position = global_position + off*to_add.direction
	$RayCast2D.cast_to = direction * off * 1.5
	if $RayCast2D.is_colliding():
		to_add.free()
	else:
		$Node.add_child(to_add)
