extends Node
class_name MenuTransition

func setup_tween(menu: Menu) -> Tween:
	menu.current_transition = self
	return menu.create_tween()

func transition(menu: Menu, show: bool) -> void:
	menu.current_transition = null
	menu.visible = show

func is_simultaneous() -> bool: return true
