extends SpecialAttack

onready var projectile := preload('res://_projectiles/BossLightningSpecialProjectile.tscn')
onready var projectile_speed := 250
var shot_pos: Vector2
var shot_pos_spacing := 100
var number_projectiles := 5
var projectiles_to_fire := 0
var projectile_space := .1

#put behavior here to telecast the bosses actions before he attacks full force
func _transition():
	boss_body.get_node('Particles2D').modulate = Damage.damage_color[type]


#set attack behavior in this method
func _attack():
	projectiles_to_fire = number_projectiles
	shot_pos.x = boss_body.global_position - 500
	shot_pos.y = -1200
	
	if projectiles_to_fire > 0 :
		_add_projectile(shot_pos)
		projectiles_to_fire -= 1
		$DelayTimer.start(projectile_space)

func _add_projectile(_position, proj := projectile):
	var to_add = proj.instance()
	to_add.shot_by = 'boss'
	to_add.speed = projectile_speed
	to_add.type = type
	to_add.direction = Vector2.DOWN
	to_add.position = _position
	$Node.add_child(to_add)
	shot_pos.x += shot_pos_spacing


#end attack specific behavior in this method
func _attack_over():
	pass