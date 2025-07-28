extends Node
class_name MenuTransition

func setup_tween(menu: Menu) -> Tween:
	menu.current_transition = self
	var tween := menu.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	return tween

func transition(menu: Menu, show: bool) -> void:
	menu.current_transition = null
	menu.visible = show

func is_simultaneous() -> bool: return true
