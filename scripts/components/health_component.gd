extends Node2D

signal died

@export var total_health: float

func _on_hit_taken(damage: float) -> void:
	total_health -= damage
	if total_health <= 0:
		died.emit()
