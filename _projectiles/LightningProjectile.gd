extends Projectile

onready var cast := $RayCast2D

func _physics_process(delta):
	cast.cast_to = direction * 50

func _on_hit(body):
	if body.has_method("hit") :
		body.hit(self, damage, type, knockback)
		fizzle()
	elif cast.is_colliding():
		direction = direction.bounce(cast.get_collision_normal())