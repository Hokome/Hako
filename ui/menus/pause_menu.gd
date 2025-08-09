extends Menu
class_name PauseMenu

static var enabled := false
static var game_node: Node

@export var transition: MenuTransition

func _ready() -> void:
	await get_tree().process_frame
	if !transition:
		transition = menu_stack.NO_TRANSITION

func toggle_pause() -> bool:
	var tree := get_tree()
	tree.paused = !tree.paused
	
	if tree.paused:
		menu_stack.navigate(self, true, transition)
	else:
		menu_stack.back(transition)
	
	return tree.paused

func _unhandled_input(event: InputEvent) -> void:
	if !enabled: return
	if event.is_echo() or !event.is_pressed():
		return
	if event.is_action("pause"):
		toggle_pause()
		accept_event()

func back_to_main() -> void:
	await menu_stack.navigate(menu_stack.starting_menu, true, transition)
	if game_node:
		game_node.queue_free()
	get_tree().paused = false
	
	enabled = false
