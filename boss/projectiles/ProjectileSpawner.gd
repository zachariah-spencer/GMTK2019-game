extends Node2D

export(PackedScene) var projectile
export var type := 1
var rot = 0


func fire():
	rot += (15 * PI/180)
	var to_add = projectile.instance()
	to_add.position = global_position
	to_add.direction = Vector2.RIGHT.rotated(rot)
	$Node.add_child(to_add)
	to_add = projectile.instance()
	to_add.position = global_position
	to_add.direction = Vector2.LEFT.rotated(rot)
	$Node.add_child(to_add)
