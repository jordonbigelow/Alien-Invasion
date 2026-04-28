extends Area2D

signal hit(damage_amount: float)
signal is_killed(points_for_kill: int)

@export var points: int

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		hit.emit(area.damage_amount)
		area.queue_free()

func _on_health_component_died() -> void:
	queue_free()
	
func _ready() -> void:
	add_to_group("alien_invaders")

func _on_health_component_out_of_lives() -> void:
	is_killed.emit(points)
