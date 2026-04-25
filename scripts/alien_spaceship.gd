extends Area2D

signal died

func _on_area_entered(area: Area2D) -> void:
	died.emit()
	area.queue_free()
	queue_free()
