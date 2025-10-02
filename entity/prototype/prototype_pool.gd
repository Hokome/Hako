extends Node
class_name PrototypePool

var available: Array[Prototype] = []
var drain: bool

func fill(registry: Registry, filter: Callable = _allow_all) -> void:
	if not filter:
		filter = _allow_all
	var filtered := registry.prototypes.values().filter(filter)
	available.append_array(filtered)
	available.shuffle()

## Gives random entries out of the available prototypes.
## If [member drain] is true, the entries will be removed from the pool.
## [param unique] will be ignored if [member drain] is true.
func pull(
	count: int = 1,
	unique: bool = true,
	rng: RandomNumberGenerator = RNG.default_rng
) -> Array[Prototype]:
	var results: Array[Prototype] = []
	while count:
		if available.is_empty():
			break
		elif unique and available.size() - results.size() <= 0:
			break
		var index := rng.randi_range(0, available.size() - 1)
		var result: Prototype = available[index]
		if drain:
			available.remove_at(index)
		elif unique:
			if results.has(available[index]):
				continue
		results.push_back(result)
		count -= 1
	return results

func _allow_all(_p: Prototype): return true
