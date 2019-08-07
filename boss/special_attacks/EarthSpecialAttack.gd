extends SpecialAttack

onready var move_timer := $MoveTimer
onready var upcast := $UpCast
onready var downcast := $DownCast
var attack_active := false

#put behavior here to telecast the bosses actions before he attacks full force
func _transition():
	boss_body.get_node('Particles2D').modulate = Damage.damage_color[type]


#set attack behavior in this method
func _attack():
	attack_active = true
	boss.move_handling_enabled = false
	_zig_zag_move()


#end attack specific behavior in this method
func _attack_over():
	boss.move_handling_enabled = true
	attack_active = false
	boss_body.get_node('Particles2D').modulate = Color.white
	move_timer.stop()


func _zig_zag_move():
	if downcast.is_colliding():
		boss.velocity.y = -5 * 64
	else:
		boss.velocity.y = 20 * 64
	
	move_timer.start()

func _on_Area2D_body_entered(body):
	if downcast.is_colliding() && attack_active:
		Global.player.get_node('Camera2D').shake(.2, 15, 15)
		if Global.player.is_on_floor():
			Global.player.hit(boss,1, Damage.earth, Vector2(0,-200))
