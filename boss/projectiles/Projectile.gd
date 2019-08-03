extends Node2D

var damage = 3
var knockback = Vector2.ZERO
var type = 0
var direction = Vector2.LEFT
var speed = 50

var time = PI

onready var fizzle_timer = $FizzleTimer

func _physics_process(delta):
	time += delta
	position += Vector2.UP.rotated(direction.angle()) * sin(time*4)
	position += speed*direction*delta
	if !fizzle_timer.is_stopped() :
		modulate.a = fizzle_timer.time_left

func _on_hit(body):
	if body.has_method("hit") :
		body.hit(self, damage, type, knockback)

	fizzle()

func fizzle():
	$FizzleTimer.start()
