extends Control

onready var background := $Background
onready var main_menu := $VBoxContainer/MainMenu
onready var fullscreen := $VBoxContainer/Fullscreen
onready var quit_game := $VBoxContainer/QuitGame

func _toggle_pause():
	var p_state := get_tree().paused
	p_state = not p_state
	
	get_tree().paused = p_state
	visible = p_state

func _process(delta):
	if Input.is_action_just_pressed('pause'):
		_toggle_pause()

func _on_MainMenu_pressed():
	if get_tree().paused:
		print('goto title_screen')


func _on_Fullscreen_pressed():
	if get_tree().paused:
		OS.window_fullscreen = !OS.window_fullscreen


func _on_QuitGame_pressed():
	if get_tree().paused:
		get_tree().quit()
