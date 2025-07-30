extends Control

@export var audio_slider_scene: PackedScene
@export var slider_label_scene: PackedScene
@export var slider_parent: Node

func _ready() -> void:
	if !slider_parent:
		slider_parent = self
	
	for bus_name in Settings.current.volumes:
		create_slider(bus_name)

func create_slider(bus_name: String) -> void:
	var bus_index := AudioServer.get_bus_index(bus_name)
	var label: Label = slider_label_scene.instantiate()
	label.name = "label %s" % bus_name
	label.text = bus_name
	
	var slider: HSlider = audio_slider_scene.instantiate()
	slider.name = "slider %s" % bus_name
	slider.value = AudioServer.get_bus_volume_linear(bus_index)
	slider.value_changed.connect(apply_volume.bind(bus_index))
	
	slider_parent.add_child(label)
	slider_parent.add_child(slider)

func apply_volume(value: float, bus_index: int) -> void:
	AudioServer.set_bus_volume_linear(bus_index, value)
