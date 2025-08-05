extends Control
class_name ControlSettingsTab

@export var grid: GridContainer

@export var label_scene: PackedScene
@export var button_scene: PackedScene

var remap_groups: Array[RemapGroup]
var focused_button: RemapButton = null
var listening: bool

func _ready() -> void:
	for action_name in settings.action_whitelist:
		var rg := RemapGroup.new()
		rg.control_settings_tab = self
		rg.label = label_scene.instantiate()
		grid.add_child(rg.label)
		
		for i in grid.columns - 1:
			var button: RemapButton = button_scene.instantiate()
			button.index = i
			grid.add_child(button)
			rg.register_button(button)
			button.focus_exited.connect(button_focused.bind(null))
			button.focus_entered.connect(button_focused.bind(button))
			button.pressed.connect(listen_input.bind(button))
		
		rg.action_name = action_name
		remap_groups.push_back(rg)

func refresh() -> void:
	for g in remap_groups:
		g.refresh_events()

func listen_input(remap_button: RemapButton) -> void:
	remap_button.release_focus()
	button_focused(remap_button)
	
	for g in remap_groups:
		g.set_disabled(true)
	
	remap_button.text = "Listening..."
	listening = true

func end_listen() -> void:
	listening = false
	for g in remap_groups:
		g.refresh_events()
	focused_button.grab_focus()

func button_focused(button: RemapButton) -> void:
	focused_button = button

func _unhandled_input(event: InputEvent) -> void:
	if !listening || !event.is_pressed(): return
	if event.is_action("cancel_remap"):
		focused_button.assign(null)
		accept_event()
	elif event is InputEventMouseButton or InputEventJoypadButton or InputEventKey:
		focused_button.assign(event)
		accept_event()
