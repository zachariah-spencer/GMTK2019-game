extends Area2D

signal start_game
var started = false

func _on_GameStart_body_entered(body):
	if body is Player and not started :
		started = true
		emit_signal("start_game")
		yield(get_tree().create_timer(1.0), "timeout")
		Global.set_player_limits()
