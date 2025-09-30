@abstract
extends Node
class_name StatusEffect

signal applied(Entity2D)
signal cured
signal merged(StatusEffect)

var current_entity: Entity2D

func apply(entity: Entity2D) -> void:
	current_entity = entity
	applied.emit(entity)

func cure() -> void:
	cured.emit()
	queue_free()

func merge(other: StatusEffect) -> void:
	merged.emit(other)
