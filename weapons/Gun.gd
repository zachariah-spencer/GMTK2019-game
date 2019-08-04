extends Node2D

var charge_types := {
1 : preload('res://_projectiles/FireProjectile.tscn'),
2 : preload('res://_projectiles/LightningProjectile.tscn'),
3 : preload('res://_projectiles/WaterProjectile.tscn'),
4 : preload('res://_projectiles/EarthProjectile.tscn'),
5 : preload('res://_projectiles/AirProjectile.tscn'),
}

export var projectile_speed := 180.0
var charge_type := 0
var accent_phase_mod := 0.0

onready var accent := $Accent

func _ready():
	_update_accent(charge_type)
	charge(2)

func _physics_process(delta: float):
	accent.modulate.a = .5 * sin(accent_phase_mod) + .5
	accent_phase_mod += .08

func _update_accent(new_charge_type := charge_type):
	accent.modulate = Damage.damage_color[new_charge_type]

func charge(new_charge):
	charge_type = new_charge
	_update_accent()

func _get_charge():
	if charge_type != 0:
		return charge_types[charge_type]

func shoot():
	if charge_type != 0:
		_add_projectile(_get_charge())
		charge_type = 0
		_update_accent()

func _add_projectile(projectile):
	var to_add = projectile.instance()
	to_add.speed = projectile_speed
	to_add.direction = Vector2.RIGHT.rotated(rotation)
	to_add.position = global_position + 10 * to_add.direction
	$Node.add_child(to_add)