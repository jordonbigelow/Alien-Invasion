extends Area2D

@export var speed: float = 600.0
var velocity = Vector2.UP * speed

func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
