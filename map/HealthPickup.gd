extends Node2D

onready var pickup_area := $PickupArea
onready var sprite := $Sprite

var picked_up := false

signal picked_up

func _ready():
	connect('picked_up', get_parent().get_parent(), 'on_picked_up')

func _physics_process(delta):
	if picked_up:
		sprite.modulate.a -= .1
		if sprite.modulate.a <= 0.0:
			queue_free()

func _on_PickupArea_body_entered(body):
	var player = body as Player
	
	if player:
		emit_signal('picked_up')
		picked_up = true
		player.hp = 5
