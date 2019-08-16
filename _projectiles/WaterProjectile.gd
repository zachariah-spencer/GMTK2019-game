extends Projectile

export var damage_growth := 1.0

func _ready():
	speed = 200

func _move(delta : float) :
	position +=  delta*speed*direction
	$CollisionShape2D.shape.radius += delta  * 4
