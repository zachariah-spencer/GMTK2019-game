extends Node2D
class_name SpecialAttack

export(int, "void", "fire", "lightning", "water", "earth", "air") var type := 0

onready var duration := $Duration
onready var boss_body := $'../..'
onready var boss := $'../../..'
onready var player = Global.player
onready var transition_duration := $TransitionDuration

signal special_attack_finished

func _ready():
	connect('special_attack_finished', boss, 'on_special_attack_finished')
	add_to_group(str(type))

func attack():
	transition_duration.start()
	_transition()
	yield(transition_duration,'timeout')
	duration.start()
	_attack()

#put behavior here to telecast the bosses actions before he attacks full force
func _transition():
	pass


#set attack behavior in this method
func _attack():
	pass

#end attack specific behavior in this method
func _attack_over():
	pass

func _on_Duration_timeout():
	emit_signal('special_attack_finished')
	_attack_over()
