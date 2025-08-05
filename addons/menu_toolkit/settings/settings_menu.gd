extends Menu
class_name SettingsMenu

signal settings_refreshed

var backup: Settings = null

func _ready() -> void:
	visibility_changed.connect(_on_visible)

func _on_visible():
	if visible:
		backup = settings.current.clone()
		settings_refreshed.emit()

func cancel() -> void:
	settings.current = backup
	settings.apply()

func reset_settings() -> void:
	settings.current = settings.default.clone()
	settings.apply()
	settings_refreshed.emit()

func save_settings() -> void:
	backup = null
	settings.apply()
	settings.save_file()
