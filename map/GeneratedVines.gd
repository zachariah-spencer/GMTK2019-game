extends Vines

export var normal := Vector2.LEFT
export var size := 100.0

onready var upcast := $UpCast
onready var downcast := $DownCast
onready var inupcast := $InUpCast
onready var indowncast := $InDownCast

func _ready():
	rotation = normal.angle()
	upcast.cast_to.y = -size * .5
	downcast.cast_to.y = size * .5

	inupcast.position.y = -size * .5
	indowncast.position.y = size * .5

	inupcast.cast_to.y = size * .5
	indowncast.cast_to.y = -size * .5


	var up = size/2
	var down = size/2


	upcast.force_raycast_update()
	downcast.force_raycast_update()
	inupcast.force_raycast_update()
	indowncast.force_raycast_update()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	var cast_offset = Vector2(-7, 0)
	if inupcast.is_colliding() :
		down = inupcast.get_collision_point().distance_to(upcast.global_position + cast_offset.rotated(rotation))
	if indowncast.is_colliding() :
		up = indowncast.get_collision_point().distance_to(downcast.global_position + cast_offset.rotated(rotation))

	if upcast.is_colliding() :
		up = upcast.get_collision_point().distance_to(upcast.global_position)
	if downcast.is_colliding() :
		down = downcast.get_collision_point().distance_to(downcast.global_position)


	var real_size = up + down

	$ClimbShape.shape.extents.y = real_size * .5
	$ClimbShape.position.y = (down - up) *.5

	$Sprite.scale.y = real_size * 1/64
	$Sprite.position.y = (down-up) * .5
