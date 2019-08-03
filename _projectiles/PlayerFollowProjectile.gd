extends Projectile

var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]

func _move(delta : float ):
	var dir = (player.global_position - global_position).normalized()
	position += delta*speed*dir
