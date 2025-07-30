extends BaseButton
class_name SceneLoadButton

@export var game_scene: PackedScene

func _ready() -> void:
	pressed.connect(play)

func play() -> void:
	if !game_scene:
		push_error("No scene was set for loading with button '%s'" % self)
		return
	
	var scene := game_scene.instantiate()
	await menu_stack.navigate(null, true)
	PauseMenu.enabled = true
	PauseMenu.game_node = scene
	get_tree().root.add_child(scene)
