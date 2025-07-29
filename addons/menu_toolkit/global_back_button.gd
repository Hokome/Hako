extends BaseButton
class_name GlobalBackButton

@export var transition: MenuTransition

func _ready() -> void:
	pressed.connect(back)

func back() -> void:
	menu_stack.back(transition)
