extends Obstruction

var activated := false
export(Damage.damage_types) var deactivation_type := 0

signal deactivate

func hit(by : Node2D, damage : int, type : int, knockback : Vector2):
	if type ==  activation_type :
		emit_signal("activate")
		activate()
	if type == deactivation_type :
		emit_signal("deactivate")
		deactivate()

func activate():
	$Area2D.collision_mask = 0
	$DestroySound.play()
	$CPUParticles2D.emitting = false

func deactivate():
	$Area2D.collision_mask = 18
	$IgniteSound.play()
	$CPUParticles2D.emitting = true