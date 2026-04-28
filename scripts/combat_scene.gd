extends Node2D

var remaining_aliens: int
var projectiles_fired: int

func _process(_delta: float) -> void:
	remaining_aliens = get_tree().get_nodes_in_group("alien_invaders").size()
	if remaining_aliens <= 0:
		#print("total score: " + str(total_score))
		print("total projectiles fired: "+ str(projectiles_fired))
		get_tree().paused = true

func _on_player_spaceship_shoot(projectile: Variant, location: Variant) -> void:
	var projectile_instance = projectile.instantiate()
	add_child(projectile_instance)
	projectile_instance.position = location
	projectiles_fired += 1
