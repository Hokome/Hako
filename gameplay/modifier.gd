@abstract
extends Resource
class_name Modifier

func get_priority() -> int:
	return 0

func get_merge_string() -> String:
	return ""

func merge(_other: Modifier) -> void:
	pass

func pipei(current: int) -> int:
	return current

func pipef(current: float) -> float:
	return current
