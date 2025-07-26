extends Button
class_name BackButton

func _ready() -> void:
	pressed.connect(back)

func back() -> void:
	if MenuStack.main:
		MenuStack.main.back()
