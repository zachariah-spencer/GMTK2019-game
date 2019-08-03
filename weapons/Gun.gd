extends Node2D

var charge_type
var accent_phase_mod := 0.0

onready var accent := $Accent

func _ready():
	_update_accent(charge_type)

func _physics_process(delta: float):
	accent.modulate.a = .5 * sin(accent_phase_mod) + .5
	accent_phase_mod += .08

func _update_accent(new_charge_type):
	match new_charge_type:
		_:
			accent.modulate = Color.black

func charge():
	pass