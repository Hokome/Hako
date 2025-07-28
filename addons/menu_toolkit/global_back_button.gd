extends BaseButton
class_name GlobalBackButton

func _ready() -> void:
	pressed.connect(back)

func back() -> void:
	menu_stack.back()
