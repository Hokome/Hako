extends Resource
class_name Settings

var volumes: Dictionary[String, float] = {}
var remaps: Dictionary[String, Array] = {}

func clone() -> Settings:
	var new: Settings = self.duplicate()
	new.volumes = self.volumes.duplicate(true)
	new.remaps = self.remaps.duplicate(true)
	
	return new
