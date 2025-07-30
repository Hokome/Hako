extends Resource
class_name Settings

static var default: Settings = make_default()
static var current: Settings = default
const bus_white_list: PackedStringArray = [
	"Master",
	"Music",
	"SFX",
]

static func make_default() -> Settings:
	var settings := Settings.new()
	
	for i in AudioServer.bus_count:
		var name := AudioServer.get_bus_name(i)
		if !bus_white_list.has(name):
			continue
		
		settings.volumes[name] = AudioServer.get_bus_volume_linear(i)
	
	return settings

var volumes: Dictionary[String, float]
var remaps: Dictionary[String, String]

func apply() -> void:
	pass
