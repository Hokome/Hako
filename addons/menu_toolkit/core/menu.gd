extends Control
class_name Menu

signal transitioned(shown: bool)
signal back_with_key

## Prevent [method MenuStack.back] from hiding this menu.
@export var is_root: bool = false
@export var first_focus: Control

func end_transition(show: bool) -> void:
	if first_focus:
		first_focus.grab_focus()
	transitioned.emit(show)
