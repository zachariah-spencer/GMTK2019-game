extends ProjectileSpawner

var number_projectiles := 1
var projectiles_to_fire := 0
var projectile_space := .1

func _ready():
	activated = true

func fire(offset):
	projectiles_to_fire = number_projectiles
	self.offset = offset
	_fire()

func _fire() :
	if projectiles_to_fire > 0 :
		_add_projectile((player.global_position - global_position).normalized(), projectile, offset)
		projectiles_to_fire -= 1
		$DelayTimer.start(projectile_space)
