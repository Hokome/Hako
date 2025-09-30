extends CharacterBody2D
class_name Entity2D

signal died

var status: EntityStatus
@onready var hp: CappedInt = get_node_or_null("hp")

func _ready() -> void:
	status = EntityStatus.new()
	status.name = "status"
	add_child(status)
	var hp_bar := get_node_or_null("hp_bar")
	if hp_bar:
		connect_hp(hp_bar)
	if hp:
		hp.value_zero.connect(die)

func damage(amount: int) -> void:
	if not hp:
		return
	hp.value -= amount

func die() -> void:
	died.emit()
	queue_free()

func connect_hp(ui: Range) -> void:
	if not hp:
		return
	
	ui.min_value = 0
	ui.max_value = hp.max_value
	ui.value = hp.value
	ui.rounded = true
	ui.step = 1
	
	hp.value_changed.connect(ui.set_value)
	hp.max_value_changed.connect(ui.set_max)
