extends StatusEffect
class_name ModifierStatusEffect

@export var modifier: Modifier

func _ready() -> void:
	modifier = modifier.duplicate()

func apply(entity: Entity2D) -> void:
	for pipe in get_pipes(entity):
		pipe.apply_modifier(modifier)

func clear(entity: Entity2D) -> void:
	for pipe in get_pipes(entity):
		pipe.cure(modifier)

func merge(effect: StatusEffect) -> void:
	var e := effect as MobilityStatusEffect
	modifier.merge(e.modifier)

func get_pipes(_entity: Entity2D) -> Array[PipeValue]:
	return []
