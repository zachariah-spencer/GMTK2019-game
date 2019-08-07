extends Vines

export var normal := Vector2.LEFT
export var size := 100.0

onready var upcast := $UpCast
onready var downcast := $DownCast

func _ready():
	rotation = normal.angle()
	upcast.cast_to.y = -size/2
	downcast.cast_to.y = size/2

	var up = size/2
	var down = size/2
	upcast.force_raycast_update()
	downcast.force_raycast_update()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	if upcast.is_colliding() :
		up = upcast.get_collision_point().distance_to(upcast.global_position)


	if downcast.is_colliding() :
		down = downcast.get_collision_point().distance_to(downcast.global_position)

	var real_size = up + down

	$ClimbShape.shape.extents.y = real_size/2
	$ClimbShape.position.y = (down - up) * .5
	print($ClimbShape.position)

	$Sprite.scale.y = real_size/64
	$Sprite.position.y = down-up - 4
