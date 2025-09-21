extends Node2D
class_name InteractionIndicator2D

var owning_source: InteractionSource2D
var current_target: InteractionTarget2D

func _init() -> void:
	visible = false

func borrow(target: InteractionTarget2D) -> void:
	visible = true
	detach(current_target)
	reparent(target)
	position = Vector2.ZERO
	current_target = target
	target.tree_exiting.connect(recall)

func give_back(target: InteractionTarget2D) -> void:
	if target != current_target:
		return
	detach(target)
	recall()

func detach(target: InteractionTarget2D) -> void:
	if !target: return
	if target.tree_exiting.is_connected(recall):
		target.tree_exiting.disconnect(recall)

func recall() -> void:
	reparent(owning_source)
	visible = false
