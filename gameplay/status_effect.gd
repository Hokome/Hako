@abstract
extends Timer
class_name StatusEffect

func apply(_entity: Entity2D) -> void:
	pass

func cure(_entity: Entity2D) -> void:
	pass

func merge() -> void:
	pass

func merge_string() -> StringName:
	return &"status"
