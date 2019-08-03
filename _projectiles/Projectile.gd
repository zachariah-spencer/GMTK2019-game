extends Area2D

class_name Projectile

export(Color, RGBA) var color := Color.white
export var damage := 1
export var knockback := Vector2.ZERO
export(int, "void", "fire", "lightning", "water", "earth", "air") var type := 0
var direction := Vector2.LEFT
export var speed := 70
var lifetime := 3

var time = PI

onready var fizzle_timer = $FizzleTimer

func _ready():
	color = Damage.damage_color[type]
	$LifeTimer.start(lifetime)

func _physics_process(delta):
	if !fizzle_timer.is_stopped() :
		modulate.a = fizzle_timer.time_left
		$CollisionShape2D.shape.radius *= .8
	else :
		_move(delta)
	time += delta
	update()

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, color)


func _move(delta : float):
	position += speed*direction*delta

func _on_hit(body):
	if body.has_method("hit") :
		body.hit(self, damage, type, knockback)
	fizzle()

func fizzle():
	if $FizzleTimer.is_stopped() :
		set_deferred("monitoring", false)
		$FizzleTimer.start()
