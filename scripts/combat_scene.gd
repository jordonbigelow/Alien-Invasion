extends Node2D

var total_score: int = 0
var remaining_aliens: int
var projectiles_fired: int
var h_spacing: float = 45.0
var v_spacing: float = 45.0

const ALIEN_SCENE: PackedScene = preload("res://scenes/alien_spaceship.tscn")

@onready var alien_group: Node2D = $AlienInvaders

func _on_player_spaceship_shoot(projectile: Variant, location: Variant) -> void:
	var projectile_instance = projectile.instantiate()
	projectile_instance.add_to_group("projectiles")
	add_child(projectile_instance)
	projectile_instance.position = location
	projectiles_fired += 1

func _on_alien_spaceship_killed(points_for_kill: int) -> void:
	total_score += points_for_kill 
	
func _ready() -> void:
	for row in range(5):
		for col in range(11):
				var alien = ALIEN_SCENE.instantiate()
				alien.position = Vector2(col * h_spacing, row * v_spacing)
				alien.connect("is_killed", _on_alien_spaceship_killed)
				add_child(alien)

func _process(_delta: float) -> void:
	remaining_aliens = get_tree().get_nodes_in_group("alien_invaders").size()
	if remaining_aliens <= 0:
		print("total score: " + str(total_score))
		print("total projectiles fired: "+ str(projectiles_fired))
		get_tree().paused = true
