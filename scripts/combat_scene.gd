extends Node2D

var total_score: int = 0
var remaining_aliens: int

func _on_player_spaceship_shoot(projectile: Variant, location: Variant) -> void:
	var projectile_instance = projectile.instantiate()
	projectile_instance.add_to_group("projectiles")
	add_child(projectile_instance)
	projectile_instance.position = location

func _on_alien_spaceship_died() -> void:
	total_score += 1

func _process(_delta: float) -> void:
	remaining_aliens = get_tree().get_nodes_in_group("aliens").size()
	if remaining_aliens <= 0:
		print("total aliens killed: " + str(total_score))
		get_tree().paused = true
