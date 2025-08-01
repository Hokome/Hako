extends CharacterBody2D
class_name Entity2D

@export var base_speed: float

var direction: Vector2:
	set(val):
		direction = val.normalized()

func _physics_process(_delta: float) -> void:
	velocity = direction * base_speed
	move_and_slide()
