extends Resource
class_name Settings

var volumes: Dictionary[String, float] = {}
var remaps: Dictionary[String, Array] = {}
var window_mode: int = Window.MODE_WINDOWED
var resolution: Vector2i = Vector2i(1920, 1080)
var fps: int = 60
var vsync: bool = false

func clone() -> Settings:
	var new: Settings = self.duplicate()
	new.volumes = self.volumes.duplicate(true)
	new.remaps = self.remaps.duplicate(true)
	
	return new
