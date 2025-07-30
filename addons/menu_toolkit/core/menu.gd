extends Control
class_name Menu

signal transitioned(bool)

## Prevent [method MenuStack.back] from hiding this menu.
@export var is_root: bool = false

func end_transition(show: bool) -> void:
	transitioned.emit(show)
