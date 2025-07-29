extends Node

func _ready() -> void:
	await get_tree().process_frame
	var example_menu := $examples
	example_menu.reparent(menu_stack)
	menu_stack.get_node("main_menu/play").navigate_to = example_menu
