extends Node2D
class_name CursorFollow

func _process(_delta: float) -> void:
	var parent := get_parent()
	if parent and parent is Node2D:
		parent.global_position = get_global_mouse_position()
