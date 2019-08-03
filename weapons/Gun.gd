extends Node2D

var charge_types := {
'fire': preload('res://_projectiles/FireProjectile.tscn'),
'lightning': preload('res://_projectiles/LightningProjectile.tscn'),
}

export var projectile_speed := 180
var charge_type: String = ''
var accent_phase_mod := 0.0

onready var accent := $Accent

func _ready():
	_update_accent(charge_type)
	charge('lightning')

func _physics_process(delta: float):
	accent.modulate.a = .5 * sin(accent_phase_mod) + .5
	accent_phase_mod += .08

func _update_accent(new_charge_type := charge_type):
	match new_charge_type:
		'fire':
			accent.modulate = Color.red
		_:
			accent.modulate = Color.black

func charge(new_charge):
	charge_type = new_charge
	_update_accent()

func _get_charge():
	if charge_type != '':
		return charge_types[charge_type]

func shoot():
	if charge_type != '':
		_add_projectile(_get_charge())
		charge_type = ''
		_update_accent()

func _add_projectile(projectile):
	var to_add = projectile.instance()
	to_add.speed = projectile_speed
	to_add.direction = Vector2.RIGHT.rotated(rotation)
	to_add.position = global_position + 10 * to_add.direction
	$Node.add_child(to_add)