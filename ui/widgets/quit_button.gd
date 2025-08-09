extends BaseButton
class_name QuitButton

func _ready() -> void:
	pressed.connect(get_tree().quit)
