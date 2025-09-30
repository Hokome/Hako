extends StatusEffect
class_name ModifierStatusEffect

@export var modifier: Modifier

func _ready() -> void:
	modifier = modifier.duplicate()

func apply(entity: Entity2D) -> void:
	for pipe in get_pipes(entity):
		pipe.apply_modifier(modifier)
	super(entity)

func cure() -> void:
	for pipe in get_pipes(current_entity):
		pipe.remove_modifier(modifier)
	super()

func merge(other: StatusEffect) -> void:
	var effect := other as MobilityStatusEffect
	modifier.merge(effect.modifier)
	super(other)

func get_pipes(_entity: Entity2D) -> Array[PipeValue]:
	return []
