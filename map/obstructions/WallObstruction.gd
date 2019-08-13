extends Node2D

var open = false


func activate():
	if not open :
		open = true
		$AnimationPlayer.play("Open")
	else :
		open = false
		$AnimationPlayer.play_backwards("Open")
		yield(get_tree().create_timer(.45), "timeout")
		var crushed = $CrushCheck.get_overlapping_bodies()
		if crushed.size() > 0 :
			for crush in crushed :
				if crush.has_method("hit") :
					crush.hit(self, 1, 0, Vector2.ZERO)
			$AnimationPlayer.stop()
			open = true
			$AnimationPlayer.play("Open")


