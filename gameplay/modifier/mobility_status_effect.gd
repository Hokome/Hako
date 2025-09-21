extends ModifierStatusEffect
class_name MobilityStatusEffect

func get_pipes(entity: Entity2D) -> Array[PipeValue]:
	return [entity.speed]
