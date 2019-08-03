extends Node2D

var damage = 3
var knockback = Vector2.ZERO
var type = 0
var direction = Vector2.LEFT
var speed = 10

var time = 0

onready var fizzle_timer = $FizzleTimer

func _physics_process(delta):
	time += delta
	position.y += sin(time)
	position += speed*direction
	if !fizzle_timer.is_stopped() :
		modulate.a = fizzle_timer.time_left

func _on_hit(body):
	if body.has_method("hit") :
		body.hit(self, damage, type, knockback)

	fizzle()

func fizzle():
	$FizzleTimer.start()
