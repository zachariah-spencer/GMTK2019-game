extends Node2D

class_name ProjectileSpawner

export(PackedScene) var projectile
export(Damage.damage_types) var type := 0
export var speed := 130.0
var offset := 15
var player : Node2D
export var activated := false
export var number_projectiles := 1
var projectiles_to_fire := 0
export var projectile_space := .1
export var cooldown := .1

func _ready():
	add_to_group(str(type))
	player = Global.player


func _add_projectile(direction, proj := projectile, off := offset, t := type):
	var to_add = proj.instance()
	to_add.speed = speed
	to_add.type = t
	to_add.direction = direction
	to_add.position = global_position + off*direction
	$RayCast2D.cast_to = direction * off * 1.5
	if $RayCast2D.is_colliding():
		to_add.free()
	else:
		$Node.add_child(to_add)

func clear_projectiles():
	pass

func fire(offset):
	self.offset = offset
	if $CooldownTimer.is_stopped():
		projectiles_to_fire = number_projectiles
		$CooldownTimer.start(cooldown)
		_fire()


func _fire():
	pass

func activate():
	activated = true

