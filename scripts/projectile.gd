extends Area2D

@export var speed: float = 600.0
var velocity = Vector2.UP * speed

func _physics_process(delta: float) -> void:
	position += velocity * delta
