extends Node

var player
var boss
const CELL_SIZE = 64

const LIMIT_LEFT = -320
const LIMIT_RIGHT = 3200
const LIMIT_TOP = -1120
const LIMIT_BOT = 352

var won := true

var monster_roar_sfx_scene := preload('res://ui/MonsterRoarSFX.tscn')
var GAMEOVER = preload('res://ui/GameOver.tscn')
var transition_screen := preload('res://ui/TransitionScreen.tscn')

func game_end(win : bool):
	won = win
	
	if !win:
		var sfx = monster_roar_sfx_scene.instance()
		get_tree().get_root().add_child(sfx)
		sfx.play()
	
	
	var trans = transition_screen.instance()
	get_tree().get_root().add_child(trans)
	yield(trans, 'covered')
	get_tree().change_scene_to(GAMEOVER)