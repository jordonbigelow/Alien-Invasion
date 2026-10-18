extends Node2D

var total_score: int = 0
var h_spacing: float = 45.0
var v_spacing: float = 45.0
var direction: int = 1
var step_count: int = 0
var h_step_amount: float = 1.0
var left_limit: float = 30.0
var right_limit: float = 670.0
var alien_count = 0

@onready var alien_sound_fx := $AlienSoundFX

@export var rows = 5
@export var cols = 11

const ALIEN_SCENE: PackedScene = preload("res://scenes/alien_spaceship.tscn")

func _ready() -> void:
	for row in range(rows):
		for col in range(cols):
				var alien = ALIEN_SCENE.instantiate()
				alien_count += 1
				alien.name = "Alien_Spaceship_" + str(alien_count)
				alien.position = Vector2(col * h_spacing, row * v_spacing)
				alien.connect("hit", _on_alien_spaceship_killed)
				add_child(alien)

func _process(_delta: float) -> void:
	_step()

func _on_alien_spaceship_killed(points_for_kill: int) -> void:
	alien_sound_fx.play(1.25)
	total_score += points_for_kill

func _step() -> void:
	position.x = clampf(position.x, left_limit, right_limit)
	position.x += h_step_amount * direction
	if position.x >= right_limit or position.x <= left_limit:
		_step_down()
		direction *= -1

func _step_down() -> void:
	position.y += 25
