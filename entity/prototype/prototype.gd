extends Resource
class_name Prototype

enum Rarity {
	COMMON = 10,
	RARE = 3,
}

@export var rarity: Rarity = Rarity.COMMON
@export var tags: PackedStringArray
## Can be leaved empty and set automatically
@export var id: String

func get_weight() -> float: return rarity

func tag_matches(compare: PackedStringArray) -> PackedStringArray:
	var matches := PackedStringArray()
	# Tags is more likely to be empty than compare, so iterating tags
	for tag in tags:
		if compare.has(tag):
			matches.push_back(tag)
	return matches

func get_thumbnail() -> Texture2D:
	return null
