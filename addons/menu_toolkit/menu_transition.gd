extends Resource
class_name MenuTransition

var tween: Tween
var target: Menu
var direction: bool = false

func setup(menu: Menu, show: bool) -> Tween:
	target = menu
	direction = show
	tween = menu.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	return tween

func transition(menu: Menu, show: bool) -> void:
	target = menu
	direction = show
	finish()

func finish() -> void:
	target.visible = direction
	tween = null

func is_simultaneous() -> bool: return true

func fast_forward() -> void:
	if tween:
		tween.stop()
	finish()
