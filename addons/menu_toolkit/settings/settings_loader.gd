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

func _ready() -> void:
	default = make_default()
	load_file()

func make_default() -> Settings:
	var settings := Settings.new()
	
	for bus_name in bus_whitelist:
		var bus_index := AudioServer.get_bus_index(bus_name)
		
		settings.volumes[bus_name] = AudioServer.get_bus_volume_linear(bus_index)
	
	for action_name in action_whitelist:
		var events := InputMap.action_get_events(action_name)
		
		settings.remaps[action_name] = events
	
	return settings

func load_file() -> void:
	if !FileAccess.file_exists(save_path):
		return default.clone()
	var file := FileAccess.get_file_as_string(save_path)
	var dict: Dictionary = str_to_var(file)
	
	current = Settings.new()
	
	current.volumes = dict.get("volumes", default.volumes)
	current.remaps = dict.get("remaps", default.remaps)
	
	apply()

func save_file() -> void:
	var file := FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(var_to_str({
		"volumes": current.volumes,
		"remaps": current.remaps,
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
	
	var vsync := DisplayServer.VSYNC_DISABLED
	if s.vsync:
		vsync = DisplayServer.VSYNC_ENABLED
	DisplayServer.window_set_vsync_mode(vsync)
	Engine.max_fps = s.fps
	
	if !get_tree().root.is_embedded():
		DisplayServer.window_set_mode(s.window_mode)
		DisplayServer.window_set_size(s.resolution)
