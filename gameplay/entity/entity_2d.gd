extends CharacterBody2D
class_name Entity2D

var status: EntityStatus

func _ready() -> void:
	status = EntityStatus.new()
	status.name = "status"
	add_child(status)
