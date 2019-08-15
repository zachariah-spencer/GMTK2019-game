extends Control

onready var main_level := load('res://map/Level.tscn')
onready var transition_screen := load('res://ui/TransitionScreen.tscn')
onready var title_screen := load('res://ui/TitleScreen.tscn')

func _ready():
	if Global.won :
		$Panel/Label.text = "Victory"
		$Panel/Label.modulate = Color.green
	else :
		$Panel/Label.text = "Game Over"
		$Panel/Label.modulate = Color.red


func restart():
	var trans = transition_screen.instance()
	get_tree().get_root().add_child(trans)
	yield(trans, 'covered')
	get_tree().change_scene_to(main_level)

func quit():
	get_tree().quit()


func _on_MainMenu_pressed():
	var trans = transition_screen.instance()
	get_tree().get_root().add_child(trans)
	yield(trans, 'covered')
	get_tree().change_scene_to(title_screen)
