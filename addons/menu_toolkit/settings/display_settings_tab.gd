extends Control

@export var scale_spin: SpinBox
@export var window_dropdown: OptionButton
@export var fps_dropdown: OptionButton
@export var vsync_button: CheckButton

func _ready() -> void:
	vsync_button.toggled.connect(set_vsync)
	
	scale_spin.value_changed.connect(set_content_scale)
	
	window_dropdown.add_item("Windowed")
	window_dropdown.add_item("Borderless")
	window_dropdown.add_item("Fullscreen")
	
	window_dropdown.item_selected.connect(select_mode)

func refresh() -> void:
	var s := settings.current
	vsync_button.button_pressed = s.vsync
	scale_spin.value = s.content_scale
	
	# Offset useless window modes
	var mode_index := s.window_mode
	if mode_index > 0:
		mode_index -= 2
	window_dropdown.select(mode_index)

func set_vsync(value: bool) -> void:
	var vsync := DisplayServer.VSYNC_ENABLED if value else DisplayServer.VSYNC_DISABLED
	settings.current.vsync = value
	DisplayServer.window_set_vsync_mode(vsync)

func set_content_scale(content_scale: float) -> void:
	settings.current.content_scale = content_scale
	var window := get_tree().root
	if !window.is_embedded():
		window.content_scale_factor = settings.current.content_scale

func select_mode(index: int) -> void:
	# Offset useless window modes
	if index > 0:
		index += 2
	
	settings.current.window_mode = index
	if !get_tree().root.is_embedded():
		get_tree().root.mode = settings.current.window_mode

func select_framerate() -> void:
	pass
