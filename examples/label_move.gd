extends Label

@export var speed := 80.0
@export var limit := 120.0

var direction := Vector2.DOWN

func _process(delta: float) -> void:
	position += delta * direction * speed
	if limit < absf(position.y + size.y / 2.0):
		direction = -direction
