extends Node2D

class_name ProjectileSpawner

export(PackedScene) var projectile
export var type := 1
var offset := 15

func _add_projectile(direction, proj := projectile, off := offset):
	var to_add = proj.instance()
	to_add.direction = direction
	to_add.position = global_position + off*direction
	$Node.add_child(to_add)

func clear_projectiles():
	pass

func fire():
	_add_projectile(Vector2.UP)
	_add_projectile(Vector2.DOWN)
	_add_projectile(Vector2.LEFT)
	_add_projectile(Vector2.RIGHT)
	_add_projectile(Vector2.ONE)
	_add_projectile(-Vector2.ONE)
	_add_projectile(Vector2(-1, 1))
	_add_projectile(Vector2(1, -1))

