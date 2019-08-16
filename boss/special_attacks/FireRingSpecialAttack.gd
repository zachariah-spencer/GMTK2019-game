extends SpecialAttack

onready var fire_particles := $FireParticles
onready var jump_timer := $JumpTimer
onready var damage_area := $DamageArea
var attack_active := false

export var jump_timing := 1.0
export var jump_variation := .5

func _transition():
	._transition()
	fire_particles.emitting = true

func _attack():
	$JumpTimer.start(rand_range(jump_timing - jump_variation, jump_timing + jump_variation))
	_erratic_move()
	attack_active = true
	damage_area.monitoring = true

func _erratic_move():
	var player_dir = player.global_position - boss_body.global_position

#	if player_dir.y > 0 or boss.line_of_sight.is_colliding() :
#		boss.velocity.y = -boss.high_jump_v
#	else :
	boss.velocity.y = -boss.low_jump_v

	boss.velocity.x = sign(player_dir.x) * 500

#func _physics_process(delta):
#	fire_particles.rotation += delta * 20
#
#	if boss_body.is_on_floor() && attack_active && jump_timer.is_stopped():
#		jump_timer.start()

func _attack_over():
	._attack_over()
	$JumpTimer.stop()
	attack_active = false
	damage_area.monitoring = false
	fire_particles.emitting = false


func _on_JumpTimer_timeout():
	$JumpTimer.start(rand_range(jump_timing - jump_variation, jump_timing + jump_variation))
	_erratic_move()


func _on_DamageArea_body_entered(body):
	var player = body as Player

	if player:
		player.hit(self, 1, type, Vector2.ZERO)
