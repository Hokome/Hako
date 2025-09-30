@tool
extends Node2D
class_name AutoPoly

@export var count: int = 6
@export var radius: float = 32.0
@export_tool_button("Refresh") var refresh_points := refresh

func _ready() -> void:
	refresh()

func refresh() -> void:
	if "points" in self:
		self.points = distribute_points(count, radius)
	elif "polygon" in self:
		self.polygon = distribute_points(count, radius)

@warning_ignore("shadowed_variable")
static func distribute_points(count: int, radius: float) -> PackedVector2Array:
	var points := PackedVector2Array()
	points.resize(count)
	var theta := PI * 2 / count
	
	for i in count:
		points[i] = Vector2(radius, 0.0).rotated(theta * i)
	return points
