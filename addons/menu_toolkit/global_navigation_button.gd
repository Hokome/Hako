extends BaseButton
class_name GlobalNavigationButton

@export var navigate_to: Menu
@export var overwrite: bool = false
@export var transition: MenuTransition

func _ready() -> void:
	pressed.connect(navigate)

func navigate() -> void:
	menu_stack.navigate(navigate_to, overwrite, transition)
