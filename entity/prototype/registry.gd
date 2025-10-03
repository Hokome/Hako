extends Node
class_name Registry

@export var prototypes: Dictionary[String, Prototype] = {}

func load_folder(path: String, pipe: Callable = auto_id) -> void:
	var files := PackedStringArray()
	for filename in DirAccess.open(path).get_files():
		var f := path.path_join(filename)
		if ResourceLoader.exists(f, "Prototype"):
			files.push_back(f)
	
	var loader := ParallelLoader.new()
	loader.files = files.duplicate()
	loader.pipe = pipe
	loader.start()
	
	while not loader.is_finished():
		continue
	
	for prototype in loader.results:
		if prototypes.has(prototype.id):
			push_error("Duplicate prototypes %s[%s]" % [name, prototype.id])
		prototypes[prototype.id] = prototype

static func auto_id(prototype: Prototype) -> void:
	var filename := prototype.resource_path.get_file()
	prototype.id = filename.trim_suffix(".tres")
