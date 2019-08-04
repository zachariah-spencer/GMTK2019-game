extends Node2D

signal hit

func hit(by : Node2D, damage : float, type : int, knockback : Vector2):
	emit_signal("hit", by, damage, type, knockback)
