extends Node2D

class_name ProjectileSpawner

export(PackedScene) var projectile
export var type := 1
export var speed := 130
var offset := 15
var player : Node2D

func _ready():
	add_to_group(str(type))
	player = Global.player


func _add_projectile(direction, proj := projectile, off := offset, t := type):
	var to_add = proj.instance()
	to_add.speed = speed
	to_add.type = t
	to_add.direction = direction
	to_add.position = global_position + off*direction
	$Node.add_child(to_add)

func clear_projectiles():
	pass

func fire(offset):
	pass

