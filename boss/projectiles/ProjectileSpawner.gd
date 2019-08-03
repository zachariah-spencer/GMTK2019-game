extends Node2D

export(PackedScene) var projectile

func fire():
	var to_add = projectile.instance()
	to_add.direction = Vector2.RIGHT
	add_child(to_add)
	to_add	 = projectile.instance()
	to_add.direction = Vector2.LEFT
	add_child(to_add)
