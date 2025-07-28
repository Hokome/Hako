@tool
extends EditorPlugin
class_name MenuBox

const PAUSE_ACTION_NAME := "pause"
const AUTOLOAD_NAME := "menu_stack"

func _enter_tree() -> void:
	InputMap.add_action(PAUSE_ACTION_NAME)
	
	var key_event := InputEventKey.new()
	key_event.physical_keycode = KEY_ESCAPE
	InputMap.action_add_event(PAUSE_ACTION_NAME, key_event)
	
	var gamepad_event := InputEventJoypadButton.new()
	gamepad_event.button_index = JOY_BUTTON_START
	InputMap.action_add_event(PAUSE_ACTION_NAME, gamepad_event)
	
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/menu_toolkit/main_menu_stack.tscn")

func _exit_tree() -> void:
	InputMap.erase_action(PAUSE_ACTION_NAME)
	remove_autoload_singleton(AUTOLOAD_NAME)
