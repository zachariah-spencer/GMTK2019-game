extends ProjectileSpawner

var number_projectiles := 5
var projectiles_to_fire := 0
var projectile_space := .05

func fire(offset):
	projectiles_to_fire = number_projectiles
	self.offset = offset
	$FireDelay.start()

func _on_FireDelay_timeout():
	_fire(offset)

func _fire(offset):
	var direction = player.global_position - global_position
	
	_add_wall(2, direction.normalized(), offset)

func _add_wall(num_projectiles, dir, off):
	var spacing = 18
	var to_add = projectile.instance()
	to_add.speed = speed
	to_add.type = type
	to_add.direction = dir
	var base_off = global_position + off*dir
	to_add.position = base_off
	$Node.add_child(to_add)
	
	var off_d = dir.rotated(PI/2)
	for i in range(1, num_projectiles+1) :
		to_add = projectile.instance()
		to_add.speed = speed
		to_add.type = type
		to_add.direction = dir
		to_add.position = base_off + ( i * spacing * off_d )
		$Node.add_child(to_add)
	
	off_d = dir.rotated(-PI/2)
	for i in range(1, num_projectiles+1) :
		to_add = projectile.instance()
		to_add.speed = speed
		to_add.type = type
		to_add.direction = dir
		to_add.position = base_off + ( i * spacing * off_d )
		$Node.add_child(to_add)
