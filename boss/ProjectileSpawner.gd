extends Node2D

class_name ProjectileSpawner

export(PackedScene) var projectile
export var type := 1
export var speed := 130
var offset := 15
var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]


func _add_projectile(direction, proj := projectile, off := offset):
	var to_add = proj.instance()
	to_add.speed = speed
	to_add.direction = direction
	to_add.position = global_position + off*direction
	$Node.add_child(to_add)

func clear_projectiles():
	pass

func fire():
	pass

