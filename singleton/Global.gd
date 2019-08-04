extends Node

var player
const CELL_SIZE = 64

var tilemap

const LIMIT_LEFT = -320
const LIMIT_RIGHT = 1760
const LIMIT_TOP = -1120
const LIMIT_BOT = 352

var won : bool

var GAMEOVER = preload('res://map/GameOver.tscn')

func end_game(win : bool):
	won = win
	get_tree().change_scene_to(GAMEOVER)
