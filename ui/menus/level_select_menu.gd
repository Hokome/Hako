extends Menu
class_name LevelSelectMenu

@export var levels: Array[Level] = []
@export var button_parent: Node
@export var button_scene: PackedScene

func _ready() -> void:
	refresh()

func refresh() -> void:
	if not button_parent:
		button_parent = self
	Util.free_children(button_parent)
	
	for level in levels:
		var button: LevelButton
		if button_scene:
			button = button_scene.instantiate()
		else:
			var base_node: Node = Button.new()
			base_node.set_script(LevelButton)
			button = base_node
		button_parent.add_child(button)
		button.level = level
