extends CharacterBody2D
class_name EntityTop2D

@export var speed: PipeValue

var direction: Vector2:
	set(val):
		direction = val.normalized()

func _physics_process(_delta: float) -> void:
	velocity = direction * speed.computef()
	move_and_slide()
