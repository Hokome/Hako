extends Node
class_name MenuStack

static var main: MenuStack

@export var is_main: bool = true
@export var starting_menu: Menu

var _stack: Array[Menu]

func _init() -> void:
	if is_main:
		main = self

func _ready() -> void:
	for c in get_children():
		if c is Menu:
			c.visible = false
	
	if starting_menu:
		navigate(starting_menu)

func navigate(menu: Menu, overwrite: bool = false) -> void:
	if !menu:
		return
	if overwrite:
		for m in _stack:
			m.visible = false
	else:
		if !_stack.is_empty():
			var last: Menu = _stack.back()
			last.visible = false
	
	_stack.push_back(menu)
	menu.visible = true

func back() -> Menu:
	var menu: Menu = _stack.pop_back()
	
	if menu:
		if menu.is_root: return null
		menu.visible = false
	if !_stack.is_empty():
		var previous_menu: Menu = _stack.back()
		previous_menu.visible = true
	
	return menu
