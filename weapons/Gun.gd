extends Node2D

var charge_types := {
Damage.fire : preload('res://_projectiles/FireProjectile.tscn'),
Damage.lightning : preload('res://_projectiles/LightningProjectile.tscn'),
Damage.water : preload('res://_projectiles/WaterProjectile.tscn'),
Damage.earth : preload('res://_projectiles/EarthProjectile.tscn'),
Damage.air : preload('res://_projectiles/AirProjectile.tscn'),
}

export var base_projectile_speed := 180.0
var charge_type := 0
var accent_phase_mod := 0.0

onready var accent := $Accent
onready var base := $Base

func _ready():
	_update_accent(charge_type)
	charge(0)

func _physics_process(delta: float):
	accent.modulate.a = .5 * sin(accent_phase_mod) + .5
	accent_phase_mod += .08

func _update_accent(new_charge_type := charge_type):
	accent.modulate = Damage.damage_color[new_charge_type]

func charge(new_charge):
	charge_type = new_charge
	_update_accent()

func shoot():
	if charge_type != 0:
		_handle_shot_type(charge_type)
		$Shoot.play()
		charge_type = 0
		_update_accent()

func _handle_shot_type(type):
	var projectile = charge_types[charge_type]
	print(type)
	match type:
		Damage.fire:
			_add_spread(projectile, 2.5, 3)
		Damage.lightning:
			_add_projectile(projectile, 5.0)
		Damage.earth:
			_add_projectile(projectile, 1.0)
		Damage.water:
			_add_projectile(projectile, 1.0)
		Damage.air:
			_add_wall(projectile, 3, 10, 0.08)

func _add_spread(projectile, speed_mod, num_projectiles):
	var rot := -PI/22
	for i in range(0,num_projectiles):
		var to_add = projectile.instance()
		to_add.speed = base_projectile_speed * speed_mod
		to_add.type = charge_type
		to_add.direction = Vector2.RIGHT.rotated(rotation)
		to_add.direction = to_add.direction.rotated(rot)
		rot += PI/24
		to_add.position = global_position + 10 * to_add.direction
		$Node.add_child(to_add)


func _add_projectile(projectile, speed_mod):
	var to_add = projectile.instance()
	to_add.speed = base_projectile_speed * speed_mod
	to_add.type = charge_type
	to_add.direction = Vector2.RIGHT.rotated(rotation)
	to_add.position = global_position + 10 * to_add.direction
	$Node.add_child(to_add)

func _add_wall(projectile, num_projectiles, spacing, speed_mod):
	var to_add = projectile.instance()
	to_add.speed = base_projectile_speed * speed_mod
	to_add.type = charge_type
	to_add.direction = Vector2.RIGHT.rotated(rotation)
	var dir = to_add.direction
	var base_off = global_position + 10 * to_add.direction
	to_add.position = base_off
	$Node.add_child(to_add)

	var off_d = dir.rotated(PI/2)
	for i in range(1, num_projectiles) :
		to_add = projectile.instance()
		to_add.speed = base_projectile_speed * speed_mod
		to_add.type = charge_type
		to_add.direction = Vector2.RIGHT.rotated(rotation)
		to_add.position = base_off + ( i * spacing * off_d )
		$Node.add_child(to_add)

	off_d = dir.rotated(-PI/2)
	for i in range(1, num_projectiles) :
		to_add = projectile.instance()
		to_add.speed = base_projectile_speed * speed_mod
		to_add.type = charge_type
		to_add.direction = Vector2.RIGHT.rotated(rotation)
		to_add.position = base_off + ( i * spacing * off_d )
		$Node.add_child(to_add)
