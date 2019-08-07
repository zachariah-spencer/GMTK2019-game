extends Area2D
class_name Vines

func _process(delta):
	if not $WitherTimer.is_stopped() :
		$Sprite.modulate.a = $WitherTimer.time_left/$WitherTimer.wait_time
	for body  in get_overlapping_bodies() :
		if body is Player && body.can_climb:
			body._set_state(body.states.climb)

func _on_Vines_body_entered(body):
	var p = body as Player

	if p:
		p._set_state(p.states.climb)

func _on_Vines_body_exited(body):
	var p = body as Player

	if p:
		p._set_state(p.states.fall)

func hit(by : Node2D, damage : float, type : int, knockback : Vector2):
	if type == Damage.fire :
		wither()

func wither():
	##play a wither anim
	$WitherTimer.start()
