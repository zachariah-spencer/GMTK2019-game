extends SpecialAttack

onready var projectile := preload('res://_projectiles/BossSpecialWaterProjectile.tscn')
onready var projectile_speed := 250.0
var shot_pos: Vector2
var shot_pos_spacing := 100
var number_projectiles := 4
var projectiles_to_fire := 0
var projectile_space := .01

#set attack behavior in this method
func _attack():
	_shoot()

func _shoot():
	projectiles_to_fire = number_projectiles
	shot_pos = Vector2(player.global_position.x - get_viewport().size.x / 2, player.global_position.y)
	_add_projectile(shot_pos)
	
	shot_pos = Vector2(player.global_position.x + get_viewport().size.x / 2, player.global_position.y)
	_add_projectile(shot_pos)
	
	shot_pos = Vector2(player.global_position.x, player.global_position.y + get_viewport().size.y / 2)
	_add_projectile(shot_pos)
	
	shot_pos = Vector2(player.global_position.x, player.global_position.y - get_viewport().size.y / 2)
	_add_projectile(shot_pos)

func _add_projectile(_position, proj := projectile):
	var to_add = proj.instance()
	to_add.shot_by = 'boss'
	to_add.speed = projectile_speed
	to_add.type = type
	to_add.direction = Vector2.DOWN
	to_add.position = _position
	$Node.add_child(to_add)