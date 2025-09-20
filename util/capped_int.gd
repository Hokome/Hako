extends Node
class_name CappedInt

signal value_changed(new_value: int)
signal max_value_changed(new_max: int)
signal value_zero

@export var max_value: int:
	set(val):
		max_value = max(0, val)
		max_value_changed.emit(max_value)
		if value > max_value:
			value = value

var value: int:
	set(val):
		value = clampi(val, 0, max_value)
		value_changed.emit(value)
		if value == 0:
			value_zero.emit()

func _init() -> void:
	value = max_value
