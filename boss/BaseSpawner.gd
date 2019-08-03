extends ProjectileSpawner

var number_projectiles := 3
var projectiles_to_fire := 0
var projectile_space := .05

func fire():
	projectiles_to_fire = number_projectiles
	_fire()

func _fire() :
	if projectiles_to_fire > 0 :
		_add_projectile((player.global_position - global_position).normalized())
		projectiles_to_fire -= 1
		$DelayTimer.start(projectile_space)