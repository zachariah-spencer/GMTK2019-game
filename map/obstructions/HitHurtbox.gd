extends Area2D

export var hit_damage := 1.0
export(Damage.damage_types) var hit_type

func _on_hit(body) :
	if body.has_method("hit") :
		body.hit(self, hit_damage , hit_type, Vector2.ONE)

signal hit

func hit(by : Node2D, damage : float, type : int, knockback : Vector2):
	emit_signal("hit", by, damage, type, knockback)
