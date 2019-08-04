extends Obstruction

var activated := false

func _ready():
	pass # Replace with function body.

func hit(by : Node2D, damage : int, type : int, knockback : Vector2):
	if type ==  activation_type :
		activated = true
		emit_signal("activate")
		activate()

func _physics_process(delta):
	if activated && modulate.r < 1:
			modulate.r += delta
			modulate.g += delta
