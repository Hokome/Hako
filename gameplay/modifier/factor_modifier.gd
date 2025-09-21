extends Modifier
class_name FactorModifier

@export var factor: float = 1.0

func pipef(current: float) -> float:
	return current * factor

func pipei(current: int) -> int:
	return roundi(current * factor)

func get_priority() -> int:
	return 1

func merge(other: Modifier) -> void:
	factor *= other.factor
