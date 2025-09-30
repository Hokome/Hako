extends Node2D
class_name Weapon

@export var damage := PipeValue.new()
@export var cooldown := PipeValue.new()

@onready var entity: Entity2D = get_parent()

var point := Vector2.ZERO
var held := false

func press() -> void:
	pass

func release() -> void:
	pass

func aim() -> Vector2:
	return (point - global_position).normalized()

func spawn_attack(scene: PackedScene) -> Attack:
	var attack: Attack = scene.instantiate()
	entity.get_parent().add_child(attack)
	return attack
