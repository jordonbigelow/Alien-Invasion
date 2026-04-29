extends Node2D

@export var life_count: int

signal out_of_life

func _on_player_died():
	life_count -= 1
	if life_count <= 0:
		out_of_life.emit()
