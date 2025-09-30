extends Node
class_name LootSpawner

@export var table: LootTable
@export var multiplier: float = 1.0
@export var radius: float
@onready var entity: Entity2D = get_parent()

func drop_loot() -> void:
	var loot := table.roll_loot(multiplier)
	for scene in loot:
		for i in loot[scene]:
			var node: Node2D = scene.instantiate()
			entity.get_parent().add_child(node)
			node.global_position = entity.global_position + RNG.even_circle(radius)
