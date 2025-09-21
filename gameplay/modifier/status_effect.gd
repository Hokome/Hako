@abstract
extends Node
class_name StatusEffect

@export var lifetime: StatusLifetime

func apply(_entity: Entity2D) -> void:
	pass

func cure(_entity: Entity2D) -> void:
	pass

func merge(other: StatusEffect) -> void:
	if other.lifetime:
		if lifetime:
			lifetime.merge(other.lifetime)
		else:
			lifetime = other.lifetime
