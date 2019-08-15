extends Node

var player
var boss
const CELL_SIZE = 64

const LIMIT_LEFT = -536
const START_LIMIT_LEFT = -2102
const START_LIMIT_TOP = -320
const LIMIT_RIGHT = 3200
const LIMIT_TOP = -1120
const LIMIT_BOT = 352

var won := true

var GAMEOVER = preload('res://map/GameOver.tscn')

func game_end(win : bool):
	won = win
	get_tree().change_scene_to(GAMEOVER)

func set_player_limits(left = LIMIT_LEFT, right = LIMIT_RIGHT, top = LIMIT_TOP, bot = LIMIT_BOT):
	var cam = player.get_node("Camera2D")
	cam.limit_left = left
	cam.limit_bottom = bot
	cam.limit_top = top
	cam.limit_right = right