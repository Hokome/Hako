extends Control

@export var grid: GridContainer
@export var configurable_controls: PackedStringArray

@export var label_scene: PackedScene
@export var button_scene: PackedScene

var remap_buttons: Array[RemapButton] = []

func _ready() -> void:
	for action_name in configurable_controls:
		var rb := RemapButton.new()
		rb.label = label_scene.instantiate()
		grid.add_child(rb.label)
		
		for i in grid.columns - 1:
			var button: Button = button_scene.instantiate()
			grid.add_child(button)
			rb.register_button(button)
		
		rb.action_name = action_name
		remap_buttons.push_back(rb)

class RemapButton:
	var label: Label
	var buttons: Array[Button]
	
	var action_name: String:
		set(val):
			action_name = val
			label.text = val.replace("_", " ").capitalize()
			
			refresh_events()
	
	func refresh_events() -> void:
		var events := InputMap.action_get_events(action_name)
		for i in events.size():
			if buttons.size() <= i:
				break
			buttons[i].text = events[i].as_text().replace(" (Physical)", "")
	
	func register_button(button: Button) -> void:
		buttons.push_back(button)
