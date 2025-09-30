extends Area2D
class_name InteractionTarget2D

signal interacted()
signal interacted_by(InteractionSource2D)
signal selected(InteractionSource2D)
signal deselected(InteractionSource2D)

@export var indicator_offset: Vector2

func select(source: InteractionSource2D) -> void:
	source.indicator.borrow(self)
	selected.emit(source)

func deselect(source: InteractionSource2D) -> void:
	source.indicator.give_back(self)
	deselected.emit(source)

func interact(origin: InteractionSource2D) -> void:
	interacted_by.emit(origin)
	interacted.emit()
