extends Control

onready var anim := $AnimationPlayer
onready var main_level := load('res://map/Level.tscn')
onready var transition_screen := load('res://ui/TransitionScreen.tscn')
onready var fullscreen := $VBoxContainer/Fullscreen

func _ready():
	fullscreen.pressed = OS.window_fullscreen
	anim.play('colorwheel')

func _on_Start_pressed():
	var trans = transition_screen.instance()
	get_tree().get_root().add_child(trans)
	yield(trans, 'covered')
	get_tree().change_scene_to(main_level)


func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_Quit_pressed():
	get_tree().quit()
