extends CanvasLayer

onready var anim := $AnimationPlayer

signal covered

func _ready():
	anim.play('transition')

func _transition_in():
	emit_signal('covered')
	anim.play('transition_out')