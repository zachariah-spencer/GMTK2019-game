extends ProgressBar

var health := 0.0

func _physics_process(delta):
	value = lerp(value, health*100, .01)
