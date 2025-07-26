extends Node
class_name MenuStack

static var main: MenuStack

@export var is_main: bool = true
@export var starting_menu: Menu
@export var default_transition: MenuTransition = null

var _stack: Array[Menu]

func _init() -> void:
	if is_main:
		main = self

func _ready() -> void:
	if !default_transition:
		default_transition = MenuTransition.new()
		add_child(default_transition)
	
	for c in get_children():
		if c is Menu:
			c.visible = false
	
	if starting_menu:
		navigate(starting_menu)

## Go to the provided [param menu]. If [param overwrite] is true, it will erase
## the stack and make everything invisible
func navigate(menu: Menu, overwrite: bool = false, transition: MenuTransition = null) -> void:
	if !menu:
		return
	
	if overwrite:
		for m in _stack:
			transition_menu(m, false, transition)
		_stack.clear()
	else:
		if !_stack.is_empty():
			var last: Menu = _stack.back()
			await transition_menu(last, false, transition)
	
	_stack.push_back(menu)
	await transition_menu(menu, true, transition)

## Goes to the last menu in the stack. If the [member Menu.is_root] is true,
## the function will do nothing.
func back(transition: MenuTransition = null) -> Menu:
	var menu: Menu = _stack.pop_back()
	
	if menu:
		if menu.is_root:
			_stack.push_back(menu)
			return null
		await transition_menu(menu, false, transition)
	if !_stack.is_empty():
		var previous_menu: Menu = _stack.back()
		await transition_menu(previous_menu, true, transition)
	
	return menu

func transition_menu(menu: Menu, show: bool, transition: MenuTransition) -> void:
	if !transition:
		transition = default_transition
	
	if transition.is_simultaneous():
		transition.transition(menu, show)
	else:
		@warning_ignore("redundant_await")
		await transition.transition(menu, show)
