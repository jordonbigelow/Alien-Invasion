extends Node2D

func _ready() -> void:
	position = Vector2(25.0, 25.0)
	await get_tree().create_timer(1.0).timeout
