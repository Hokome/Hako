extends TextureRect
class_name InfiniteBackground

@export var camera: Camera2D
var zoom := Vector2.ZERO

func _ready() -> void:
	z_index = -255
	stretch_mode = TextureRect.STRETCH_TILE
	if !camera:
		camera = get_parent() as Camera2D
	get_window().size_changed.connect(refresh)
	refresh()

func _process(_delta: float) -> void:
	if not camera: return
	if zoom != camera.zoom:
		refresh()
	var texsize := texture.get_size()
	position.x = -fposmod(camera.global_position.x, texsize.x)
	position.y = -fposmod(camera.global_position.y, texsize.y)
	position -= size * 0.5

func refresh() -> void:
	zoom = camera.zoom
	
	var s = Vector2(get_window().size) / zoom
	size = s * 2
