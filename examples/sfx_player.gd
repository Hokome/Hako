extends AudioStreamPlayer2D

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position() - get_viewport_rect().size / 2.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			play()
