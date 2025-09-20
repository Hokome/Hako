extends MenuTransition
class_name FadeMenuTransition

@export var time: float
var original_color: Color

func transition(menu: Menu, show: bool) -> void:
	setup(menu, show)
	
	original_color = menu.modulate
	var target_color := original_color
	if show:
		target_color.a = original_color.a
		menu.modulate.a = 0.0
		menu.visible = true
	else:
		target_color.a = 0.0
	
	tween.tween_property(menu, "modulate", target_color, time)
	
	await tween.finished
	finish()

func finish() -> void:
	super()
	target.modulate = original_color

func is_simultaneous() -> bool: return false
