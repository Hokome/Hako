extends Button
class_name RemapButton

var group: RemapGroup
var index: int
var control_settings_tab: ControlSettingsTab

func assign(event: InputEvent) -> void:
	var existing_events := InputMap.action_get_events(group.action_name)
	if existing_events.size() > index:
		InputMap.action_erase_event(group.action_name, existing_events[index])
	if event:
		InputMap.action_add_event(group.action_name, event)
	settings.current.remaps[group.action_name] = InputMap.action_get_events(group.action_name)
	control_settings_tab.end_listen()
