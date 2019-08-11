extends Projectile

func _physics_process(delta):
	$CollisionShape2D.shape.radius -= .05
	$CollisionShape2D.shape.radius = max(0,$CollisionShape2D.shape.radius)
	if $CollisionShape2D.shape.radius <= .5:
		queue_free()

func _on_hit(body):
	if body.has_method("hit") :
		body.hit(self, damage, type, knockback)
