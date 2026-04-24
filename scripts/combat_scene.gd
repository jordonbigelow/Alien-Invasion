extends Node2D

func _on_player_spaceship_shoot(projectile: Variant, location: Variant) -> void:
	var projectile_instance = projectile.instantiate()
	add_child(projectile_instance)
	projectile_instance.position = location
