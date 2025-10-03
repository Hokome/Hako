extends Node2D
class_name Cell

var grid: Grid
var grid_position: Vector2i
var color: Color = Color.from_rgba8(60, 60, 60, 255)

func create_background() -> void:
	var polygon := Polygon2D.new()
	polygon.polygon = grid.get_corners(1.0)
	polygon.color = color
	polygon.z_index = -10
	add_child(polygon)
