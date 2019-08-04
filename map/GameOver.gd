extends Control

var level = preload("res://map/Level.tscn")

func _ready():
	if Global.won :
		$Panel/Label.text = "Congratulations! \n You Won! \n Thanks for Playing"
		$Panel/Label.modulate = Color.green
	else :
		$Panel/Label.text = "Game Over..."
		$Panel/Label.modulate = Color.red


func restart():
	get_tree().change_scene_to(level)

func quit():
	get_tree().quit()
