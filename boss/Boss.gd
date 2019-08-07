extends Node2D

const CELL_SIZE = 64

var final_phase = 5

var phase := 0
var immunities := []
var health := 3.0
var total_health := 3.0
var size := 40
var transforming = false
var active := false
var performing_special = false
var move_handling_enabled := true


onready var projectile_attacks = $Body/ProjectileSpawners.get_children()
onready var special_attacks = $Body/SpecialAttacks.get_children()
onready var movement_abilities = $Body/Movement.get_children()
onready var rand = RandomNumberGenerator.new()
onready var line_of_sight = $Body/PlayerLineOfSight
onready var health_bar = $CanvasLayer/HealthBar
onready var body := $Body
onready var hp_anims := $HPAnims
onready var move_timer := $MoveTimer
onready var projectile_timer := $ProjectileTimer
onready var special_timer := $SpecialTimer
onready var shot_delay_timer := $ShotDelayTimer


var high_jump_v = sqrt(gravity * 60 * CELL_SIZE * 8)
var low_jump_v = sqrt(gravity * 60 * CELL_SIZE * 3)


signal fire_projectile
signal move
signal special_attack

const gravity = 20
var player : Node2D


func _ready():
	Global.boss = self
	_set_states()
	player = get_tree().get_nodes_in_group("player")[0]

func hit(by : Node2D, damage : float, type : int, knockback : Vector2):
	if not type in immunities :
		$Body/VulnerableHit.play()
		health -= damage
		if health <= 0 :
			activate_phase(type)
		else:
			$CanvasLayer/HealthBar.health = float(health / (phase +3))
	else :
		$Body/ImmuneHit.play()

func die() :
	$Body/Death.play()
	yield($Body/Death, "finished")
	Global.game_end(true)

func activate_phase(type : int):
	phase += 1


	if phase == final_phase :
		die()
	transforming = true
	$Body/Particles2D.initial_velocity = 10
	$Body/Transition.play()
	$MoveTimer.stop()
	$ProjectileTimer.stop()
	immunities.append(type)
	health = phase + 3
	$CanvasLayer/HealthBar.health = 1.0

	#could do this by using class_name later
	for attack in projectile_attacks :
		if attack.is_in_group(str(type)) :
			connect("fire_projectile", attack, "activate")
			emit_signal('fire_projectile')
	for move in movement_abilities :
		if move.is_in_group(str(type)) :
			connect("move", move, "move")
	#I guess this doesn't work, needs to randomly select a move
	for attack in special_attacks :
		if attack.is_in_group(str(type)) :
			connect("special_attack", attack, "activate")
			emit_signal("special_attack")

	special_timer.start()

func _fire():
	if active && !performing_special:
		for spawner in projectile_attacks :
			if spawner.activated:
				spawner.fire(size)
				yield(shot_delay_timer, 'timeout')


func _move():
	if active && !performing_special:
		projectile_timer.start()
		emit_signal("move")
		var player_dir = player.global_position - $Body.global_position
		if phase <= 0 :
			_hop()
		elif phase <= 2 :
			if player_dir.length() > Global.CELL_SIZE * 10  or line_of_sight.is_colliding() :
				_teleport()
			else :
				_hop()
		else :
			if player_dir.length() > Global.CELL_SIZE * 20  or line_of_sight.is_colliding() :
				_teleport()
			else :
				_air_impulse()

func _special():
	var usable_special := false
	
	
	#only needs to be here until we get all the elemental special attacks done
	for special in special_attacks:
		if special.activated:
			usable_special = true
	
	if active && !performing_special && usable_special:
		performing_special = true
		var selected_attack = int(rand_range(0, special_attacks.size() - .01))

		while !special_attacks[selected_attack].activated:
			selected_attack = int(rand_range(0, special_attacks.size() - .01))

		special_attacks[selected_attack].attack()

func on_special_attack_finished():
	performing_special = false
	special_timer.start()


#########################################################
#### STATE MACHINE CODE ###
#########################################################

var velocity = Vector2.ZERO

var state = null setget _set_state
var previous_state = null
var states : Dictionary = {}

func _set_states():
	_add_state('transforming')
	_add_state('hitstun')
	_add_state('special')
	_add_state('idle')
	_set_state('idle')

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
	if !transforming :
		_handle_movement(delta)
		line_of_sight.cast_to = player.global_position  - $Body.global_position
		_apply_movement()

func _get_transition(delta : float):
	match state :
		'idle':
			pass
	pass

func _physics_process(delta):
	if curr_track.volume_db < track_vol :
		curr_track.volume_db = lerp(curr_track.volume_db, track_vol, delta)
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		if transition != null:
			_set_state(transition)

func _apply_movement():
	$Body.move_and_slide(velocity, Vector2.UP)
	if phase >= 3 :
		var slide_count = $Body.get_slide_count()
		if slide_count > 0 :
			velocity = velocity.bounce($Body.get_slide_collision(slide_count -1).normal) * .5


func _handle_movement(delta : float ):
	if phase <= 2 && move_handling_enabled:
		if $Body.is_on_floor() :
			velocity.x = lerp(velocity.x, 0, .1)
		else :
			velocity += Vector2.DOWN * gravity
	elif !move_handling_enabled:
		velocity.x = lerp(velocity.x, 0, .2)

############################################################
####Move Actions ####
############################################################

func _hop():
	var player_dir = player.global_position - $Body.global_position

	if player_dir.y > 0 or line_of_sight.is_colliding() :
		velocity.y = -high_jump_v
	else :
		velocity.y = -low_jump_v
	if player.global_position.distance_to($Body.global_position) > 500 :
		velocity.x = sign(player_dir.x) * 500
	else :
		velocity.x = sign(player_dir.x) * 200

func _air_impulse():
	var player_dir = player.global_position - $Body.global_position

	var dir = rand_range(-PI/4, PI/4)

	velocity += player_dir.normalized().rotated(dir) * 300

func _teleport():
	randomize()
	var player_dir = player.global_position - $Body.global_position
	var dist = 250
	var test_point
	if player_dir.x < 0 :
		test_point = Vector2.LEFT * dist + player.global_position
	else :
		test_point = Vector2.RIGHT * dist + player.global_position

	if test_point.x > Global.LIMIT_RIGHT:
		test_point = Vector2.LEFT * dist + player.global_position
	elif  test_point.x < Global.LIMIT_LEFT :
		test_point = Vector2.RIGHT * dist + player.global_position

	$TeleportCheck.global_position = test_point
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var offset = 10
	while not $TeleportCheck.get_overlapping_bodies().empty() :
		if sign(offset) >= 0 :
			offset += 10
		offset *= -1
		$TeleportCheck.global_position = test_point
		$TeleportCheck.position.x += offset
		if test_point.x + offset > Global.LIMIT_RIGHT:
			test_point = Vector2.LEFT * dist + player.global_position
		elif  test_point.x + offset < Global.LIMIT_LEFT :
			test_point = Vector2.RIGHT * dist + player.global_position
		yield(get_tree(), "idle_frame" )
		yield(get_tree(), "idle_frame" )


	test_point.x += offset

	$Body/Teleport.play()
	velocity = Vector2.ZERO
	$Body.global_position = test_point
	$ProjectileTimer.stop()
	$ProjectileTimer.start()

onready var curr_track : AudioStreamPlayer = $Phase0
var track_vol = -1

func end_transform() :
	var cam = player.get_node("Camera2D")
	if cam.zoom.length() < Vector2.ONE.length() :
		cam.zoom += Vector2.ONE * .1

	$MoveTimer.start()
	$ProjectileTimer.start()
	transforming = false
	$Body/Particles2D.initial_velocity = 40
	if curr_track.volume_db < track_vol :
		curr_track.volume_db = track_vol
	match phase :
		1 :
			curr_track = $Phase1
			$Phase0.volume_db = -4
			track_vol = 0
		2 :
			curr_track = $Phase2
			$Phase0.volume_db = -8
			track_vol = 0
		3 :
			curr_track = $Phase3
			$Phase0.volume_db = -12
			track_vol = 0
		4 :
			curr_track = $Phase4
			$Phase0.volume_db = -15
			track_vol = 0


func _on_VisibilityNotifier2D_screen_entered():
	if !active && $ActivateTimer.is_stopped():
		$ActivateTimer.start()
		hp_anims.interpolate_property(health_bar,'modulate',Color(1,1,1,0),Color(1,1,1,1),1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		hp_anims.start()
		$CanvasLayer/HealthBar.health = 1.0


func _on_ActivateTimer_timeout():
	active = true
