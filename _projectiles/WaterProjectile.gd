extends Projectile

export var damage_growth := 1.0

func _ready():
	speed = 200

func _move(delta : float) :
	position +=  delta*speed*direction
	$CollisionShape2D.shape.radius += delta  * 4

#var boss
#
#func _ready():
#	boss = Global.boss
#
#func _move(delta : float ):
#	if global_position.distance_to(boss.body.global_position) <= 350:
#		var dir = (boss.body.global_position - global_position).normalized()
#		position += delta*speed*dir
#		direction = dir
#	else:
#		position += speed*direction*delta
