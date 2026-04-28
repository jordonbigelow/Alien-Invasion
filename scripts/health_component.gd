extends Node2D

signal died
signal out_of_lives

@export var life_count: int
@export var total_health: float
var life_lost_on_death: int = 1

func _on_hit_taken(damage: float) -> void:
	total_health -= damage

	if total_health <= 0:
		died.emit()
		life_count -= life_lost_on_death
		if life_count <= 0:
			out_of_lives.emit()
