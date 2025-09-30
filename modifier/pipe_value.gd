extends Resource
class_name PipeValue

@export var base_int: int
@export var base_float: float

#var _merge_table: Dictionary[String, Modifier] = {}
var _modifiers: Array[Modifier] = []

func computei() -> int:
	var temporary_value := base_int
	for m in _modifiers:
		temporary_value = m.pipei(temporary_value)
	
	return temporary_value

func computef() -> float:
	var temporary_value := base_float
	for m in _modifiers:
		temporary_value = m.pipef(temporary_value)
	
	return temporary_value

func apply_modifier(modifier: Modifier) -> void:
	_modifiers.push_back(modifier)
	_modifiers.sort_custom(_cmp_modifiers)

func remove_modifier(modifier: Modifier) -> void:
	_modifiers.erase(modifier)

func _cmp_modifiers(a: Modifier, b: Modifier) -> bool:
	return a.get_priority() < b.get_priority()

static func from_base_int(value: int) -> PipeValue:
	var p := PipeValue.new()
	p.base_int = value
	return p

static func from_base_float(value: float) -> PipeValue:
	var p := PipeValue.new()
	p.base_float = value
	return p
