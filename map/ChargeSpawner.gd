extends Node2D


export(PackedScene) onready var charge
export(Damage.damage_types) var type := 0
onready var spawn_pos := $SpawnPos
onready var spawned_charges := $SpawnedCharges
onready var cd_timer := $CooldownTimer

func _ready():
	_spawn_charge()


func _spawn_charge():
	var to_add = charge.instance()
	to_add.global_position = spawn_pos.global_position
	to_add.type = type
	to_add.connect("picked_up", self, 'on_charge_picked_up')
	spawned_charges.add_child(to_add)

func on_charge_picked_up():
	$Pickup.play()
	cd_timer.start()

func _on_CooldownTimer_timeout():
	if spawned_charges.get_children().empty():
		_spawn_charge()
