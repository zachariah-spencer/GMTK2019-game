extends Node2D

class_name Obstruction

export(Damage.damage_types) var activation_type := 0

signal activate

func _ready():
	pass

func hit(by : Node2D, damage : int, type : int, knockback : Vector2):
	if type ==  activation_type :
		emit_signal("activate")
		activate()

func activate() :
	pass
