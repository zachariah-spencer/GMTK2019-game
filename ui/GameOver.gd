extends Control

onready var main_level := load('res://map/Level.tscn')
onready var transition_screen := load('res://ui/TransitionScreen.tscn')
onready var title_screen := load('res://ui/TitleScreen.tscn')
onready var hbox := $HBoxContainer
onready var confirm_quit := $ConfirmQuit
onready var heart_monitor_sfx := $HeartMonitorSFX
onready var monster_roar_sfx := $MonsterRoarSFX
func _ready():

	if Global.won :
		$Panel/Label.text = "Victory"
		$Panel/Label.modulate = Color.green
	else :
#		monster_roar_sfx.play()
		heart_monitor_sfx.play()
		$Panel/Label.text = "Game Over"
		$Panel/Label.modulate = Color.red


func restart():
	var trans = transition_screen.instance()
	get_tree().get_root().add_child(trans)
	yield(trans, 'covered')
	get_tree().change_scene_to(main_level)

func quit():
	confirm_quit.popup()


func _on_MainMenu_pressed():
	var trans = transition_screen.instance()
	get_tree().get_root().add_child(trans)
	yield(trans, 'covered')
	get_tree().change_scene_to(title_screen)


func _on_ConfirmQuit_confirmed():
	get_tree().quit()
