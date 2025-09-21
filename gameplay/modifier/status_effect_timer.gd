extends Timer
class_name StatusEffectTimer

var effect: StatusEffect

func _ready() -> void:
	effect = get_parent()
	effect.applied.connect(start.unbind(1))
	timeout.connect(effect.cure)

func merge(other: StatusEffect) -> void:
	var timer: StatusEffectTimer = other.get_node_or_null(name as String)
	if timer:
		wait_time = time_left + timer.wait_time
		stop()
		start()
