extends Node2D

var charge_types := {
1 : preload('res://_projectiles/FireProjectile.tscn'),
2 : preload('res://_projectiles/LightningProjectile.tscn'),
3 : preload('res://_projectiles/WaterProjectile.tscn'),
4 : preload('res://_projectiles/EarthProjectile.tscn'),
5 : preload('res://_projectiles/AirProjectile.tscn'),
}

export var projectile_speed := 180.0
var charge_type := 0
var accent_phase_mod := 0.0

onready var accent := $Accent
onready var base := $Base

func _ready():
	_update_accent(charge_type)
	charge(0)

func _physics_process(delta: float):
	accent.modulate.a = .5 * sin(accent_phase_mod) + .5
	accent_phase_mod += .08

func _update_accent(new_charge_type := charge_type):
	accent.modulate = Damage.damage_color[new_charge_type]

func charge(new_charge):
	charge_type = new_charge
	_update_accent()

func shoot():
	if charge_type != 0:
		_add_projectile(charge_types[charge_type], charge_type)
		$Shoot.play()
		charge_type = 0
		_update_accent()

func _add_projectile(projectile, projectile_type):
	match projectile_type:
		Damage.fire:
			var numprojectiles := 3
			var rot := -PI/22
			for i in range(0,numprojectiles):
				var to_add = projectile.instance()
				to_add.shot_by = 'player'
				to_add.speed = projectile_speed * 1.8
				to_add.type = charge_type
				to_add.direction = Vector2.RIGHT.rotated(rotation)
				to_add.direction = to_add.direction.rotated(rot)
				rot += PI/24
				to_add.position = global_position + 10 * to_add.direction
				$Node.add_child(to_add)
		Damage.lightning:
			var to_add = projectile.instance()
			to_add.shot_by = 'player'
			to_add.speed = projectile_speed * 2.5
			to_add.type = charge_type
			to_add.direction = Vector2.RIGHT.rotated(rotation)
			to_add.position = global_position + 10 * to_add.direction
			$Node.add_child(to_add)
		Damage.water:
			var to_add = projectile.instance()
			to_add.shot_by = 'player'
			to_add.speed = projectile_speed * .5
			to_add.type = charge_type
			to_add.direction = Vector2.RIGHT.rotated(rotation)
			to_add.position = global_position + 10 * to_add.direction
			$Node.add_child(to_add)
		Damage.earth:
			var to_add = projectile.instance()
			to_add.shot_by = 'player'
			to_add.speed = projectile_speed * .5
			to_add.type = charge_type
			to_add.direction = Vector2.RIGHT.rotated(rotation)
			to_add.position = global_position + 10 * to_add.direction
			$Node.add_child(to_add)
		Damage.air:
			var num_projectiles := 3
			var spacing = 10
			var to_add = projectile.instance()
			to_add.speed = projectile_speed * .05
			to_add.shot_by = 'player'
			to_add.type = charge_type
			to_add.direction = Vector2.RIGHT.rotated(rotation)
			var dir = to_add.direction
			var base_off = global_position + 10 * to_add.direction
			to_add.position = base_off
			$Node.add_child(to_add)

			var off_d = dir.rotated(PI/2)
			for i in range(1, num_projectiles) :
				to_add = projectile.instance()
				to_add.shot_by = 'player'
				to_add.speed = projectile_speed * .05
				to_add.type = charge_type
				to_add.direction = Vector2.RIGHT.rotated(rotation)
				to_add.position = base_off + ( i * spacing * off_d )
				$Node.add_child(to_add)

			off_d = dir.rotated(-PI/2)
			for i in range(1, num_projectiles) :
				to_add = projectile.instance()
				to_add.shot_by = 'player'
				to_add.speed = projectile_speed * .05
				to_add.type = charge_type
				to_add.direction = Vector2.RIGHT.rotated(rotation)
				to_add.position = base_off + ( i * spacing * off_d )
				$Node.add_child(to_add)

		_:
			var to_add = projectile.instance()
			to_add.shot_by = 'player'
			to_add.speed = projectile_speed
			to_add.type = charge_type
			to_add.direction = Vector2.RIGHT.rotated(rotation)
			to_add.position = global_position + 10 * to_add.direction
			$Node.add_child(to_add)
