extends Node2D

@export var speed := 200.0

func _physics_process(delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	input = input.normalized() * speed
	
	position += input * delta
