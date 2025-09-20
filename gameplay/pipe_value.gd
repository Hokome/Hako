extends Resource
class_name PipeValue

@export var base_int: int
@export var base_float: float

var modifiers: Array[ValueModifier] = []

func computei() -> int:
	var temporary_value := base_int
	for m in modifiers:
		temporary_value = m.pipei(temporary_value)
	
	return temporary_value

func computef() -> float:
	var temporary_value := base_float
	for m in modifiers:
		temporary_value = m.pipef(temporary_value)
	
	return temporary_value
