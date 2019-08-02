extends KinematicBody2D

export var hp := 100
export var move_speed: float = CELL * 4.5
export var jump_height: float = CELL * 10


const CELL := 64
var velocity := Vector2.ZERO
var gravity := CELL / 2
var state = null setget _set_state
var previous_state = null
var states: Dictionary = {}

func _physics_process(delta: float):
	_state_logic(delta)

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


func _input(event: InputEvent):
	if event.is_action_released('jump') && velocity.y < 0:
		print('here')
		velocity.y *= .4


func _state_machine_ready():
	_add_state('idle')
	_add_state('run')
	_add_state('jump')
	_add_state('fall')
	_add_state('disabled')
	_set_state(states.idle)


func _add_state(state_name):
	states[state_name] = states.size()


func _state_logic(delta : float):
	_handle_gravity()
	_handle_movement()
	_handle_jumping()
	_apply_velocity()


func _get_transition(delta : float):
#	match state:
#		states.idle:
#			if !is_on_floor():
#				if adjusted_velocity.y < 0:
#					return states.jump
#				elif adjusted_velocity.y >= 0:
#					return states.fall
#			elif abs(move_direction_adjusted.x) > 0.1:
#				return states.run
#		states.run:
#			if !is_on_floor():
#				if adjusted_velocity.y < 0:
#					return states.jump
#				elif adjusted_velocity.y >= 0:
#					return states.fall
#			elif abs(move_direction_adjusted.x) < 0.1:
#				return states.idle
#		states.jump:
#			if is_on_floor():
#				return states.idle
#			elif adjusted_velocity.y >= 0:
#				return states.fall
#		states.fall:
#			if move_direction_adjusted.y > 0.5:
#				set_collision_mask_bit(DROP_THRU_BIT, false)
#			elif !_is_in_platform() :
#				set_collision_mask_bit(DROP_THRU_BIT, true)
#			if wall_direction != 0 && wall_slide_cooldown.is_stopped() && move_direction.project(wall_action).length() > 0 :
#				return states.wall_slide
#			elif is_on_floor() :
#				parent.play_sound('Land')
#				return states.idle
#			elif adjusted_velocity.y < 0:
#				return states.jump
#	return null
	pass


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