extends CharacterBody2D

signal shoot(projectile, location)

@export var speed: float = 400.0
@onready var projectile: PackedScene = preload("res://scenes/projectile.tscn")

var left_limit: float = 25.0
var right_limit: float = 1127.0

func _physics_process(_delta: float) -> void:
	position.x = clamp(position.x, left_limit, right_limit)
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	
	if Input.is_action_just_pressed("shoot"):
		shoot.emit(projectile, position)
		
	move_and_slide()
