extends SpecialAttack

onready var projectile := preload('res://_projectiles/BossLightningSpecialProjectile.tscn')
onready var projectile_speed := 550.0
var shot_pos: Vector2
var shot_pos_spacing := 100
var number_projectiles := 7
var projectiles_to_fire := 0
var projectile_space := .05

#set attack behavior in this method
func _attack():
	projectiles_to_fire = number_projectiles
	shot_pos.x = boss_body.global_position.x - 300
	shot_pos.y = player.global_position.y - 350
	_shoot()

func _shoot():
	if projectiles_to_fire > 0 :
		_add_projectile(shot_pos)
		projectiles_to_fire -= 1
		$DelayTimer.start(projectile_space)

func _add_projectile(_position, proj := projectile):
	var to_add = proj.instance()
	to_add.speed = projectile_speed
	to_add.type = type
	to_add.direction = Vector2.DOWN
	to_add.position = _position
	$Node.add_child(to_add)
	shot_pos.x += shot_pos_spacing
