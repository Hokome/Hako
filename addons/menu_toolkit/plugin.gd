@tool
extends EditorPlugin
class_name MenuToolkit

const PAUSE_ACTION_NAME := "pause"
const MENU_AUTOLOAD := "menu_stack"
const SETTINGS_AUTOLOAD := "settings"

static func path(subpath: String) -> String:
	return "res://addons/menu_toolkit/%s" % subpath

func _enter_tree() -> void:
	#InputMap.add_action(PAUSE_ACTION_NAME)
	#
	#var key_event := InputEventKey.new()
	#key_event.physical_keycode = KEY_ESCAPE
	#InputMap.action_add_event(PAUSE_ACTION_NAME, key_event)
	#
	#var gamepad_event := InputEventJoypadButton.new()
	#gamepad_event.button_index = JOY_BUTTON_START
	#InputMap.action_add_event(PAUSE_ACTION_NAME, gamepad_event)
	
	add_autoload_singleton(MENU_AUTOLOAD, path("main_menu_stack.tscn"))
	add_autoload_singleton(SETTINGS_AUTOLOAD, path("settings/settings_loader.tscn"))
	
	if !ResourceLoader.exists("res://default_bus_layout.tres"):
		var bus_layout := AudioBusLayout.new()
		ResourceSaver.save(bus_layout, "res://default_bus_layout.tres")

func _exit_tree() -> void:
	#InputMap.erase_action(PAUSE_ACTION_NAME)
	remove_autoload_singleton(MENU_AUTOLOAD)
	remove_autoload_singleton(SETTINGS_AUTOLOAD)
