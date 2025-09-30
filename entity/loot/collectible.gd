extends Area2D
class_name Collectible

signal collected

@warning_ignore("unused_parameter")
func collect(entity: Entity2D) -> void:
	collected.emit()
	queue_free()
