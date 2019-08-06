extends Node2D



func _on_ClimbArea_body_entered(body):
	var p = body as Player
	
	if p:
		p._set_state(p.states.climb)

func _on_ClimbArea_body_exited(body):
	var p = body as Player
	
	if p:
		p._set_state(p.states.fall)
