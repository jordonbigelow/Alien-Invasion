extends Node2D

var total_score: int = 0
var h_spacing: float = 45.0
var v_spacing: float = 45.0
var direction: int = 1
var h_step_amount: float = 1.0
var alien_count: int = 0
var alien_half_width: float = 16.0
var bounds: Rect2 = Rect2()

@onready var alien_sound_fx := $AlienSoundFX

@export var rows = 5
@export var cols = 11

const ALIEN_SCENE: PackedScene = preload("res://scenes/alien_spaceship.tscn")
# 15 px from edge of viewport
const EDGE_BUFFER: float = 15.0

func _ready() -> void:
	for row in range(rows):
		for col in range(cols):
			var alien = ALIEN_SCENE.instantiate()
			alien_count += 1
			alien.name = "Alien_Spaceship_" + str(alien_count)
			alien.position = Vector2(col * h_spacing, row * v_spacing)
			alien.connect("hit", _on_alien_spaceship_killed)
			alien.tree_exited.connect(_recalculate_bounds)
			add_child(alien)
	_recalculate_bounds()

func _process(_delta: float) -> void:
	_step()

func _recalculate_bounds() -> void:
	var first := true
	for alien in get_children():
		if not alien.is_in_group("alien_invaders") or alien.is_queued_for_deletion():
			continue
		var r := Rect2(alien.position - Vector2(alien_half_width, alien_half_width),
				Vector2(alien_half_width * 2, alien_half_width * 2))
		if first:
			bounds = r
			first = false
		else:
			bounds = bounds.merge(r)


func _step() -> void:
	if bounds.size == Vector2.ZERO:
		return

	var screen_width := get_viewport_rect().size.x
	var left_limit := EDGE_BUFFER
	var right_limit := screen_width - EDGE_BUFFER

	var global_left := position.x + bounds.position.x
	var global_right := position.x + bounds.end.x

	position.x += h_step_amount * direction

	if direction > 0 and global_right >= right_limit:
		_step_down()
		direction = -1
	elif direction < 0 and global_left <= left_limit:
		_step_down()
		direction = 1
	
	
func _step_down() -> void:
	position.y += 25


func _on_alien_spaceship_killed(points_for_kill: int) -> void:
	alien_sound_fx.play(1.25)
	total_score += points_for_kill
	h_step_amount *= 1.015
