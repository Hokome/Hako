extends Entity2D
class_name Player2D

func _physics_process(delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = input
	super(delta)
