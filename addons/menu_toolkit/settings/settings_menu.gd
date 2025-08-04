extends Menu
class_name SettingsMenu

signal settings_refreshed

var backup: Settings = null

func _ready() -> void:
	visibility_changed.connect(_on_visible)

func _on_visible():
	if visible:
		backup = Settings.current.clone()
		settings_refreshed.emit()

func cancel() -> void:
	Settings.current = backup
	Settings.current.apply()

func reset_settings() -> void:
	Settings.current = Settings.default.clone()
	Settings.current.apply()
	settings_refreshed.emit()

func save_settings() -> void:
	backup = null
	Settings.current.apply()
	Settings.current.save_file()
