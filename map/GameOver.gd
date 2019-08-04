extends Control

var level = preload("res://map/Level.tscn")

func _ready():
	if Global.won :
		$Panel/Label.text = "Congratulations! \n You Won!"
	else :
		$Panel/Label.text = "Game Over..."

func restart():
	get_tree().change_scene_to(level)

func quit():
	get_tree().quit()
