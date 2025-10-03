extends SceneLoadButton
class_name LevelButton

@export var level: Level:
	set(val):
		level = val
		refresh()

func _ready() -> void:
	refresh()
	pressed.connect(load_scene)

func refresh() -> void:
	if not level: return
	if is_class("Button"):
		self.text = level.title

func load_scene() -> void:
	var scene := level.scene.instantiate()
	await menu_stack.navigate(null, true)
	PauseMenu.enabled = true
	PauseMenu.game_node = scene
	get_tree().root.add_child(scene)
