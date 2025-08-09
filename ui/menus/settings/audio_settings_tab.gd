extends Control

@export var audio_slider_scene: PackedScene
@export var slider_label_scene: PackedScene
@export var slider_parent: Node

func _ready() -> void:
	if !slider_parent:
		slider_parent = self
	
	for bus_name in settings.bus_whitelist:
		create_slider(bus_name)

func refresh_settings() -> void:
	for bus_name in settings.bus_whitelist:
		var slider: HSlider = slider_parent.get_node("slider %s" % bus_name)
		slider.set_value_no_signal(settings.current.volumes[bus_name])

func create_slider(bus_name: String) -> void:
	var bus_idx := AudioServer.get_bus_index(bus_name)
	var label: Label = slider_label_scene.instantiate()
	label.name = "label %s" % bus_name
	label.text = bus_name
	
	var slider: HSlider = audio_slider_scene.instantiate()
	slider.name = "slider %s" % bus_name
	slider.value_changed.connect(apply_volume.bind(bus_name))
	
	slider_parent.add_child(label)
	slider_parent.add_child(slider)

func apply_volume(value: float, bus_name: String) -> void:
	var bus_idx := AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_linear(bus_idx, value)
	settings.current.volumes[bus_name] = value
