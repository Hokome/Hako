extends Resource
class_name LootTable

@export var chances: Dictionary[Resource, float]

func roll_loot(multiplier: float = 1.0) -> Dictionary[Resource, int]:
	var results: Dictionary[Resource, int] = {}
	for entry in chances:
		var chance := chances[entry]
		var count := RNG.overflow_roll(chance * multiplier)
		results[entry] = count
	return results
