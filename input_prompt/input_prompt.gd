class_name InputPrompt

static func try_load(directory: String, filename: String) -> Texture2D:
	var path := "res://input_prompt/%s/%s.png" % [directory, filename]
	path = path.to_lower()
	if not ResourceLoader.exists(path):
		return null
	return load(path)

static func get_texture(input: InputEvent) -> Texture2D:
	if input is InputEventKey:
		return try_load("keyboard", input.as_text_physical_keycode())
	if input is InputEventMouseButton:
		return try_load("mouse", get_mouse_button_name(input.button_index))
	if input is InputEventJoypadButton:
		return try_load("playstation", input.as_text())
	return null

static func get_mouse_button_name(button_index: int) -> String:
	match button_index:
		MOUSE_BUTTON_LEFT:
			return "left"
		MOUSE_BUTTON_RIGHT:
			return "right"
		MOUSE_BUTTON_WHEEL_DOWN, MOUSE_BUTTON_WHEEL_LEFT, MOUSE_BUTTON_WHEEL_RIGHT, MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_MIDDLE:
			return "middle"
	return "mouse"
