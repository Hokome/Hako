extends Resource
class_name Settings

const SAVE_PATH := "user://settings.dat"

static var default: Settings = make_default()
static var current: Settings = load_file()

const BUS_WHITELIST: PackedStringArray = [
	"Master",
	"Music",
	"SFX",
]

const ACTION_WHITELIST: PackedStringArray = [
	"move_left",
	"move_right",
	"move_up",
	"move_down",
]

static func make_default() -> Settings:
	var settings := Settings.new()
	
	for bus_name in BUS_WHITELIST:
		var bus_index := AudioServer.get_bus_index(bus_name)
		
		settings.volumes[bus_name] = AudioServer.get_bus_volume_linear(bus_index)
	
	for action_name in ACTION_WHITELIST:
		var events := InputMap.action_get_events(action_name)
		
		settings.remaps[action_name] = events
	
	return settings

var volumes: Dictionary[String, float] = {}
var remaps: Dictionary[String, Array] = {}

static func load_file() -> Settings:
	if !FileAccess.file_exists(SAVE_PATH):
		return make_default()
	var file := FileAccess.get_file_as_string(SAVE_PATH)
	var dict: Dictionary = str_to_var(file)
	
	var settings := Settings.new()
	
	settings.volumes = dict.get("volumes", default.volumes)
	settings.remaps = dict.get("remaps", default.remaps)
	
	settings.apply()
	
	return settings

func save_file() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(var_to_str({
		"volumes": volumes,
		"remaps": remaps,
	}))

func apply() -> void:
	for bus_name in volumes:
		var bus_idx := AudioServer.get_bus_index(bus_name)
		if bus_idx < 0:
			push_error("No audio bus named %s" % bus_name)
			return
		AudioServer.set_bus_volume_linear(bus_idx, volumes[bus_name])
	
	for action_name in remaps:
		InputMap.action_erase_events(action_name)
		for event in remaps[action_name]:
			InputMap.action_add_event(action_name, event)

func clone() -> Settings:
	var new: Settings = self.duplicate()
	new.volumes = self.volumes.duplicate(true)
	new.remaps = self.remaps.duplicate(true)
	return new
