extends RefCounted
class_name RemapGroup

var label: Label
var buttons: Array[RemapButton]
var control_settings_tab: ControlSettingsTab

var action_name: String:
	set(val):
		action_name = val
		label.text = val.replace("_", " ").capitalize()
		
		refresh_events()

func refresh_events() -> void:
	set_disabled(false)
	var events := InputMap.action_get_events(action_name)
	for i in buttons.size():
		if events.size() <= i:
			buttons[i].text = ""
			break
		buttons[i].text = events[i].as_text().replace(" (Physical)", "")

func register_button(button: RemapButton) -> void:
	button.group = self
	buttons.push_back(button)
	button.control_settings_tab = control_settings_tab

func set_disabled(value: bool) -> void:
	for b in buttons:
		b.disabled = value
