extends Control

onready var anim := $AnimationPlayer
onready var main_level := load('res://map/Level.tscn')
onready var transition_screen := load('res://ui/TransitionScreen.tscn')
onready var fullscreen := $VBoxContainer/Fullscreen
onready var music_slide := $VBoxContainer/Music
onready var sfx_slide := $VBoxContainer/SFX


func _ready():
	music_slide.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index('Music')))
	sfx_slide.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index('SFX')))
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


func _on_Music_value_changed(value):
	var conv_val = linear2db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Music'), conv_val)





func _on_SFX_value_changed(value):
	var conv_val = linear2db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('SFX'), conv_val)
