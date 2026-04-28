extends Area2D

signal hit(damage_amount: float)

func _on_area_entered(area: Area2D) -> void:
	hit.emit(area.damage_amount)
	area.queue_free()

func _on_health_component_died() -> void:
	queue_free()
