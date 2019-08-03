extends KinematicBody2D

const CELL := 64

export var hp := 100
export var move_speed: float = CELL * 4.5
export var jump_height: float = CELL * 17

var aim_position := Vector2.ZERO
var targeted_position := Vector2.ZERO
var velocity := Vector2.ZERO
var gravity := CELL / 1.5

var state = null setget _set_state
var previous_state = null
var states: Dictionary = {}

onready var gun := $Gun

func _ready():
	Global.player = self
	_add_state('idle')
	_add_state('run')
	_add_state('jump')
	_add_state('fall')
	_add_state('disabled')
	_set_state(states.idle)

func _physics_process(delta: float):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		if transition != null:
			_set_state(transition)

func _apply_velocity():
	move_and_slide(velocity, Vector2.UP)

func _handle_gravity():
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravity


func _handle_movement():
	if Input.is_action_pressed('move_right'):
		velocity.x = move_speed
	elif Input.is_action_pressed('move_left'):
		velocity.x = -move_speed
	else:
		velocity.x = 0


func _handle_jumping():
	if Input.is_action_pressed('jump') && is_on_floor():
		velocity.y = -jump_height


func _handle_aiming():
	aim_position = get_local_mouse_position()
	targeted_position = get_global_mouse_position()
	gun.rotation = aim_position.angle()
	gun.position = aim_position.normalized() * 10


func _input(event: InputEvent):
	if event.is_action_released('jump') && velocity.y < 0:
		velocity.y *= .4
	
	if event.is_action_pressed('shoot'):
		gun.shoot()


func _add_state(state_name):
	states[state_name] = states.size()


func _state_logic(delta : float):
	$StateLabel.text = states.keys()[state]
	if state != states.disabled:
		_handle_gravity()
		_handle_movement()
		_handle_jumping()
		_handle_aiming()
		_apply_velocity()


func _get_transition(delta : float):
	match state:
		states.idle:
			if !is_on_floor():
				if velocity.y < 0:
					return states.jump
				elif velocity.y >= 0.1:
					return states.fall
			elif velocity.x != 0:
				return states.run
		states.run:
			if !is_on_floor():
				if velocity.y < 0:
					return states.jump
				elif velocity.y >= 0.1:
					return states.fall
			elif abs(velocity.x) < 0.1:
				return states.idle
		states.jump:
			if is_on_floor():
				return states.idle
			elif velocity.y >= 0.1:
				return states.fall
		states.fall:
			if is_on_floor():
				return states.idle
			elif velocity.y < 0:
				return states.jump
	return null


func _enter_state(new_state, old_state):
	pass


func _exit_state(old_state, new_state):
	pass


func _set_state(new_state):
	previous_state = state
	state = new_state

	if previous_state != null:
		_exit_state(previous_state, new_state)
	if new_state != null:
		_enter_state(new_state, previous_state)
