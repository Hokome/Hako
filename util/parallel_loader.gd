class_name ParallelLoader

var files: PackedStringArray = []
var type_hint: String = ""
var results: Array[Resource] = []
var errors: Array[Error] = []
var pipe: Callable = func(_r: Resource): return

func start() -> void:
	for f in files:
		var error := ResourceLoader.load_threaded_request(f, type_hint)
		if error != OK:
			files.erase(f)
		errors.push_back(error)

const INVALID_RESOURCE := ResourceLoader.THREAD_LOAD_INVALID_RESOURCE
const LOAD_FAILED := ResourceLoader.THREAD_LOAD_FAILED

func is_finished() -> bool:
	for f in files:
		var status := ResourceLoader.load_threaded_get_status(f)
		match status:
			INVALID_RESOURCE, LOAD_FAILED:
				files.erase(f)
				errors.push_back(FAILED)
			ResourceLoader.THREAD_LOAD_LOADED:
				files.erase(f)
				var resource := ResourceLoader.load_threaded_get(f)
				pipe.call(resource)
				results.push_back(resource)
	return files.is_empty()
