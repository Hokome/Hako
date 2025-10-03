extends Node2D
class_name Grid

var cell_size: float:
	set(val):
		cell_size = val
		half_cell = cell_size * 0.5
var half_cell: float

var rect: Rect2i:
	set(val):
		rect = val
		content.resize(rect.size.x * rect.size.y)

var content: Array[Cell] = []

@warning_ignore("shadowed_variable")
func _init(cell_size: float) -> void:
	self.cell_size = cell_size

func place_cell(cell: Cell, grid_pos: Vector2i) -> void:
	var index := grid_to_index(grid_pos)
	content[index] = cell
	cell.grid = self
	cell.grid_position = grid_pos
	add_child(cell)
	cell.position = grid_to_local(grid_pos)
	cell.name = "%s" % grid_pos

func get_cell(grid_pos: Vector2i) -> Cell:
	if not is_in_bounds(grid_pos):
		return null
	return content[grid_to_index(grid_pos)]

func is_in_bounds(grid_pos: Vector2i) -> bool:
	return (
		grid_pos.x >= rect.position.x
		and grid_pos.y >= rect.position.y
		and grid_pos.x < rect.end.x
		and grid_pos.y < rect.end.y
	)

## Corners positions for polygons
func get_corners(offset: float = 0.0) -> PackedVector2Array:
	var corner := half_cell + offset
	return [
		Vector2(-corner, -corner),
		Vector2(corner, -corner),
		Vector2(corner, corner),
		Vector2(-corner, corner)
	]

func grid_to_index(grid_pos: Vector2i) -> int:
	var positive := grid_pos - rect.position
	return positive.x + positive.y * rect.size.x

func grid_to_local(grid_pos: Vector2i) -> Vector2: 
	return (grid_pos as Vector2) * cell_size + Vector2.ONE * half_cell

func snap_to_grid(local_pos: Vector2) -> Vector2:
	return local_pos - local_pos.posmod(cell_size) + Vector2.ONE * half_cell

func local_to_grid(local_pos: Vector2) -> Vector2i:
	return Vector2i(local_pos - local_pos.posmod(cell_size)) / cell_size

func get_cursor_snapped() -> Vector2:
	return snap_to_grid(get_local_mouse_position())

func get_cursor_grid() -> Vector2i:
	return local_to_grid(get_local_mouse_position())
