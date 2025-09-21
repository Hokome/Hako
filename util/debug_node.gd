extends Node
class_name Debug

@export var message: String = "TEST"

func log_value(value) -> void:
	print(value)

func log_timestamp() -> void:
	var time := Time.get_datetime_dict_from_system()
	print("[%s:%s:%s]" % [time.hour, time.minute, time.second])

func log_message() -> void:
	print(message)
