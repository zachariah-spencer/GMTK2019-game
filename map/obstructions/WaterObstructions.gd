extends Node2D



func _on_HitArea_area_entered(area):
	var projectile = area as Projectile
	if projectile:
		if projectile.type == Damage.water:
			
			$HitArea.collision_layer = 0
			$HitArea.collision_mask = 0
			
			if $WaterObstruction:
				$WaterObstruction.activate()
			if $WaterObstruction2:
				$WaterObstruction2.activate()