extends Resource
class_name Settings

static var current: Settings = null
static var default: Settings = make_default()

static func make_default() -> Settings:
	var settings := Settings.new()
	return settings

var volumes: Dictionary[String, float]
var remaps: Dictionary[String, String]

func apply() -> void:
	pass
