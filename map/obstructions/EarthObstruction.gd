extends Obstruction

var activated := false

func activate():
	activated = true
	$Body.collision_layer = 1


func _physics_process(delta):
	if activated && modulate.a < 1:
		modulate.a += delta
