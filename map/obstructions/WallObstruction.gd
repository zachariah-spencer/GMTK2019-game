extends Node2D

var open = false


func activate():
	if not open :
		open = true
		$AnimationPlayer.play("Open")
	else :
		open = false
		$AnimationPlayer.play_backwards("Open")