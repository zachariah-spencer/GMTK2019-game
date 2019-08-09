extends Node2D


export(PackedScene) onready var charge
export(int, "void", "fire", "lightning", "water", "earth", "air") var type := 0
onready var spawn_pos := $SpawnPos
onready var spawned_charges := $SpawnedCharges
onready var cd_timer := $CooldownTimer

func _ready():
	_spawn_charge()


func _spawn_charge():
	var to_add = charge.instance()
	to_add.global_position = spawn_pos.global_position
	to_add.type = type
	spawned_charges.add_child(to_add)

func on_charge_picked_up():
	$Pickup.play()
	cd_timer.start()

func _on_CooldownTimer_timeout():
	if spawned_charges.get_children().empty():
		_spawn_charge()