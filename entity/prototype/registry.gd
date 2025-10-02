extends Node
class_name Registry

@export var prototypes: Dictionary[String, Prototype] = {}

func load_folder(path: String, pipe: Callable = auto_id) -> void:
	var dir := DirAccess.open(path)
	for file in dir.get_files():
		var filepath := "/".join([path, file])
		var prototype: Prototype = load(filepath)
		pipe.call(prototype, file)
		if prototypes.has(prototype.id):
			push_error("Duplicate prototypes %s[%s]" % [name, prototype.id])
		prototypes[prototype.id] = prototype

static func auto_id(prototype: Prototype, path: String) -> void:
	prototype.id = path.trim_suffix(".tres")
