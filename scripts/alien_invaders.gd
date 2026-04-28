extends Node2D

var total_score: int = 0
var h_spacing: float = 45.0
var v_spacing: float = 45.0
var direction: int = 1
var step_count: int = 0

const ALIEN_SCENE: PackedScene = preload("res://scenes/alien_spaceship.tscn")

func _ready() -> void:
	for row in range(5):
		for col in range(11):
				var alien = ALIEN_SCENE.instantiate()
				alien.position = Vector2(col * h_spacing, row * v_spacing)
				alien.connect("is_killed", _on_alien_spaceship_killed)
				add_child(alien)

func _process(delta: float) -> void:
	_step()

func _on_alien_spaceship_killed(points_for_kill: int) -> void:
	total_score += points_for_kill 

func _step() -> void:
	position.x += 1.0 * direction
	step_count += 1
	if step_count >= 500:
		_step_down()
		step_count = 0
		direction *= -1

func _step_down() -> void:
	position.y += 25
