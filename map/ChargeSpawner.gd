extends Node2D

export(NodePath) var charge
onready var spawn_pos := $SpawnPos
onready var spawned_charges := $SpawnedCharges
onready var cd_timer := $CooldownTimer

func _ready():
	_spawn_charge()


func _spawn_charge():
	var to_add = charge.instance()
	to_add.global_position = spawn_pos.global_position
	spawned_charges.add_child(to_add)


func _on_CooldownTimer_timeout():
	if $SpawnedCharges.get_children().empty():
		_spawn_charge()