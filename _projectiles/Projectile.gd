extends Area2D

class_name Projectile

var color := Color.white
export var damage := 1.0
export var knockback := Vector2.ZERO
var type := 0
var direction := Vector2.LEFT
var speed := 70.0
export var lifetime := 3.0
var shot_by := 'player'

var draw_orb := true

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
	if draw_orb :
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


func _on_Projectile_area_entered(area):
	var other_proj = area as Projectile
	if other_proj:
		if shot_by == 'player' && other_proj.shot_by == 'boss':
			other_proj.fizzle()
