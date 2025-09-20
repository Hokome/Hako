extends Control

@export var scale_spin: SpinBox
@export var window_dropdown: OptionButton
@export var fps_dropdown: OptionButton
@export var vsync_button: CheckButton

func _ready() -> void:
	vsync_button.toggled.connect(set_vsync)
	
	scale_spin.value_changed.connect(set_content_scale)
	
	for fps in settings.available_framerates:
		fps_dropdown.add_item(str(fps))
	fps_dropdown.add_item("Unlimited")
	fps_dropdown.item_selected.connect(select_framerate)
	
	window_dropdown.add_item("Windowed")
	window_dropdown.add_item("Borderless")
	window_dropdown.add_item("Fullscreen")
	
	window_dropdown.item_selected.connect(select_mode)

func refresh() -> void:
	var s := settings.current
	vsync_button.button_pressed = s.vsync
	scale_spin.value = s.content_scale
	
	if s.fps == 0:
		fps_dropdown.select(settings.available_framerates.size())
	else:
		fps_dropdown.select(settings.available_framerates.find(s.fps))
	
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
		get_tree().root.mode = settings.current.window_mode as Window.Mode

func select_framerate(index: int) -> void:
	if index < settings.available_framerates.size():
		settings.current.fps = settings.available_framerates[index]
	else:
		print(index)
		settings.current.fps = 0
	
	Engine.max_fps = settings.current.fps
