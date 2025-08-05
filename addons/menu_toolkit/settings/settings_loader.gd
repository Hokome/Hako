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

func _init() -> void:
	default = make_default()
	current = load_file()

func make_default() -> Settings:
	var settings := Settings.new()
	
	for bus_name in bus_whitelist:
		var bus_index := AudioServer.get_bus_index(bus_name)
		
		settings.volumes[bus_name] = AudioServer.get_bus_volume_linear(bus_index)
	
	for action_name in action_whitelist:
		var events := InputMap.action_get_events(action_name)
		
		settings.remaps[action_name] = events
	
	return settings

func load_file() -> Settings:
	if !FileAccess.file_exists(save_path):
		return default.clone()
	var file := FileAccess.get_file_as_string(save_path)
	var dict: Dictionary = str_to_var(file)
	
	var settings := Settings.new()
	
	settings.volumes = dict.get("volumes", default.volumes)
	settings.remaps = dict.get("remaps", default.remaps)
	
	settings.apply()
	
	return settings

func save_file() -> void:
	var file := FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(var_to_str({
		"volumes": current.volumes,
		"remaps": current.remaps,
	}))

func apply() -> void:
	for bus_name in current.volumes:
		var bus_idx := AudioServer.get_bus_index(bus_name)
		if bus_idx < 0:
			push_error("No audio bus named %s" % bus_name)
			return
		AudioServer.set_bus_volume_linear(bus_idx, current.volumes[bus_name])
	
	for action_name in current.remaps:
		InputMap.action_erase_events(action_name)
		for event in current.remaps[action_name]:
			InputMap.action_add_event(action_name, event)
