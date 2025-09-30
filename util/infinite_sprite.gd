extends Sprite2D
class_name InfiniteSprite

@export var camera: Camera2D

func _ready() -> void:
	if !camera:
		camera = get_parent() as Camera2D

func _process(_delta: float) -> void:
	if not camera: return
