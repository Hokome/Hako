extends Area2D
class_name Collector

@export var collect_radius: float = 8.0
@export var magnet_strength: float = 0.0
@onready var entity: Entity2D = get_parent()

func _physics_process(delta: float) -> void:
	for node in get_overlapping_areas():
		if node is Collectible:
			attract(node, magnet_strength * delta)

func attract(collectible: Collectible, strength: float) -> void:
	var diff := global_position - collectible.global_position
	var threshold := collect_radius + strength
	threshold *= threshold
	if diff.length_squared() < threshold:
		collectible.collect(entity)
		return
	
	var movement := diff.normalized() * strength
	collectible.global_position += movement
