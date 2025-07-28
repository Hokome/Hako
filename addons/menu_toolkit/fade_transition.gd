extends MenuTransition
class_name FadeMenuTransition

@export var time: float

func transition(menu: Menu, show: bool) -> void:
	var original := menu.modulate
	var target := original
	if show:
		menu.modulate.a = 0.0
		menu.visible = true
		target.a = 1.0
	else:
		target.a = 0.0
	
	var tweener := setup_tween(menu).tween_property(menu, "modulate", target, time)
	
	await tweener.finished
	super(menu, show)
	menu.modulate = original

func is_simultaneous() -> bool: return false
