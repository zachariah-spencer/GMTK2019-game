extends Node2D

export(PackedScene) var projectile
export var type := 1

func fire():
	var to_add = projectile.instance()
	to_add.position = global_position
	to_add.direction = Vector2.RIGHT
	$Node.add_child(to_add)
	to_add = projectile.instance()
	to_add.position = global_position
	to_add.direction = Vector2.LEFT
	$Node.add_child(to_add)
