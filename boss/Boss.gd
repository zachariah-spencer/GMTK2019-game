extends Node2D

var phase := 0
var immunities := []
var health := 3.0

onready var projectile_attacks = $ProjectileSpawners.get_children()
onready var special_attacks = $SpecialAttacks.get_children()
onready var movement_abilities = $Movement.get_children()


signal fire_projectile
signal move
signal special_attack

func _ready():
	_set_states()

func hit(by : Node2D, damage : int, type : int, knockback : Vector2):
	if not type in immunities :
		health -= damage
		if health <= 0 :
			activate_phase(type)
	else :
		pass #something that shows it's immune

func activate_phase(type : int):
	phase += 1
	immunities.append(type)
	health = phase + 3

	#could do this by using class_name later
	for attack in projectile_attacks :
		if attack.is_in_group("type") :
			attack.connect("fire", self, "fire_projectile")
	for attack in special_attacks :
		if attack.is_in_group("type") :
			attack.connect("attack", self, "special")
	for move in movement_abilities :
		if move.is_in_group("type") :
			move.connect("move", self, "move")

func _fire():
	emit_signal("fire_projectile")
	pass

func _move():
	emit_signal("move")
	pass

func _special():
	emit_signal("special_attack")
	pass


#########################################################
#### STATE MACHINE CODE ###
#########################################################

var state = null setget _set_state
var previous_state = null
var states : Dictionary = {}

func _set_states():
	_add_state('transforming')
	_add_state('hitstun')
	_add_state('special')
	_add_state('moving')
	pass

func _add_state(state_name):
	states[state_name] = states.size()

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	match old_state :
		1 :
			pass
	pass

func _set_state(new_state):
	previous_state = state
	state = new_state

	if previous_state != null:
		_exit_state(previous_state, new_state)
	if new_state != null:
		_enter_state(new_state, previous_state)


func _state_logic(delta : float):
	pass

func _get_transition(delta : float):
	match state :
		1:
			pass
	pass

func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		if transition != null:
			_set_state(transition)


func _on_MoveTimer_timeout():
	pass # Replace with function body.
