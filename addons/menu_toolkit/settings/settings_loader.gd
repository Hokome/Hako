extends Node
class_name SettingsLoader

var default: Settings = null
var current: Settings = null

@export var save_path := "user://settings.dat"

@export var bus_whitelist: PackedStringArray = [
	"Master",
	"Music",
	"SFX",
]

@export var action_whitelist: PackedStringArray = [
	"move_left",
	"move_right",
	"move_up",
	"move_down",
]

@export var available_framerates: PackedInt32Array = [
	30,
	60,
	90,
	120,
	144,
]

func _enter_tree() -> void:
	default = make_default()
	load_file()

func make_default() -> Settings:
	var s := Settings.new()
	for bus_name in bus_whitelist:
		var bus_index := AudioServer.get_bus_index(bus_name)
		
		s.volumes[bus_name] = AudioServer.get_bus_volume_linear(bus_index)
	
	for action_name in action_whitelist:
		var events := InputMap.action_get_events(action_name)
		
		s.remaps[action_name] = events
	
	s.content_scale = get_tree().root.content_scale_factor
	
	return s

func load_file() -> void:
	if !FileAccess.file_exists(save_path):
		current = default.clone()
		return
	
	var file := FileAccess.get_file_as_string(save_path)
	var dict: Dictionary = str_to_var(file)
	
	current = Settings.new()
	
	current.volumes = dict.get("volumes", default.volumes)
	current.remaps = dict.get("remaps", default.remaps)
	current.content_scale = dict.get("content_scale", default.content_scale)
	current.window_mode = dict.get("window_mode", default.window_mode)
	current.vsync = dict.get("vsync", default.vsync)
	
	apply()

func save_file() -> void:
	var file := FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(var_to_str({
		"volumes": current.volumes,
		"remaps": current.remaps,
		"content_scale": current.content_scale,
		"window_mode": current.window_mode,
		"vsync": current.vsync
	}))

func apply() -> void:
	var s := current
	for bus_name in s.volumes:
		var bus_idx := AudioServer.get_bus_index(bus_name)
		if bus_idx < 0:
			push_error("No audio bus named %s" % bus_name)
			return
		AudioServer.set_bus_volume_linear(bus_idx, s.volumes[bus_name])
	
	for action_name in s.remaps:
		InputMap.action_erase_events(action_name)
		for event in s.remaps[action_name]:
			InputMap.action_add_event(action_name, event)
	
	var vsync := DisplayServer.VSYNC_ENABLED if s.vsync else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(vsync)
	Engine.max_fps = s.fps
	
	var window := get_tree().root
	window.content_scale_factor = s.content_scale

	if !window.is_embedded():
		window.mode = s.window_mode
