extends Projectile

var player

func _ready():
	player = Global.player

func _move(delta : float ):
	var dir = (player.global_position - global_position).normalized()
	position += delta*speed*dir
