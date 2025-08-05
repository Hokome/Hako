extends Resource
class_name Settings

# They all need to be exported so duplication works
@export var volumes: Dictionary[String, float] = {}
@export var remaps: Dictionary[String, Array] = {}
@export var window_mode: int = Window.MODE_WINDOWED
@export var content_scale: float = 1.0
@export var fps: int = 60
@export var vsync: bool = false
