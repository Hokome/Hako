extends BaseButton
class_name NavigationButton

@export var navigate_to: Menu
@export var overwrite: bool = false

func _ready() -> void:
	pressed.connect(navigate)

func navigate() -> void:
	menu_stack.navigate(navigate_to, overwrite)
