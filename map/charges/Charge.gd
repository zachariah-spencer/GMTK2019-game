extends Area2D
class_name Charge

var color
var type := 1
onready var fizzle_timer = $FizzleTimer
onready var spawn_timer = $SpawnTimer
var spawn_anim := 0.0
var pulsing_time := 0.0

signal picked_up

func _ready():
	color = Damage.damage_color[type]
	spawn_timer.start()
	connect('picked_up', get_parent().get_parent(), 'on_charge_picked_up')

func _on_Charge_body_entered(body):
	var player = body as Player
	
	if player && player.gun.charge_type == 0:
		player.gun.charge(type)
		fizzle()
		emit_signal('picked_up')


func _physics_process(delta):
	if !fizzle_timer.is_stopped() :
		modulate.a = fizzle_timer.time_left
		$CollisionShape2D.shape.radius *= .8
	elif spawn_timer.is_stopped() && fizzle_timer.is_stopped():
		$CollisionShape2D.shape.radius = sin(1.5 * pulsing_time) + 8
		pulsing_time += .02
	
	update()

func _draw():
	if !spawn_timer.is_stopped():
		spawn_anim += .5
		draw_circle(Vector2.ZERO, spawn_anim, color)
	else:
		draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, color)


func fizzle():
	if $FizzleTimer.is_stopped() :
		monitoring = false
		$FizzleTimer.start()


func _on_FizzleTimer_timeout():
	queue_free()
