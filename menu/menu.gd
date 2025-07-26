extends Control
class_name Menu

## Prevent [method MenuStack.back] from hiding this menu.
@export var is_root: bool = false

var current_transition: MenuTransition
