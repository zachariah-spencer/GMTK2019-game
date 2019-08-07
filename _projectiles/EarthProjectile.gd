extends Projectile

var generated_vines = preload("res://map/GeneratedVines.tscn")

func _physics_process(delta):
	$WallCheck.cast_to = direction * 500

func _on_hit(body):
	if body.has_method("hit") :
		body.hit(self, damage, type, knockback)
	elif $WallCheck.is_colliding() :
		var normal = $WallCheck.get_collision_normal()
		var point = $WallCheck.get_collision_point()
		var wall = $WallCheck.get_collider()
		if body == wall and normal.y == 0 :
			var to_add = generated_vines.instance()
			to_add.normal = -normal
			to_add.global_position = point
			wall.get_parent().add_child(to_add)

	fizzle()
