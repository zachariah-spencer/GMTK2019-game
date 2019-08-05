extends ProjectileSpawner


func fire(offset):
	self.offset = offset
	if !$FireTimer.is_stopped():
		return
	else:
		$FireTimer.start()
		_fire()


func _fire() :
		_add_projectile(Vector2.LEFT * 2, projectile, offset)


func _add_projectile(direction, proj := projectile, off := offset, t := type):
	var to_add = proj.instance()
	to_add.shot_by = 'boss'
	to_add.speed = speed
	to_add.type = t
	to_add.direction = direction
	to_add.position = global_position + off*direction
	to_add.central_orbit = global_position
	$Node.add_child(to_add)