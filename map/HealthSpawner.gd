extends Node2D


onready var charge := preload('res://map/HealthPickup.tscn')
onready var spawn_pos := $SpawnPos
onready var spawned := $Spawned
onready var cd_timer := $CooldownTimer

func _ready():
	_spawn_health()


func _spawn_health():
	var to_add = charge.instance()
	to_add.global_position = spawn_pos.global_position
	spawned.add_child(to_add)

func on_picked_up():
	cd_timer.start()

func _on_CooldownTimer_timeout():
	if spawned.get_children().empty():
		_spawn_health()