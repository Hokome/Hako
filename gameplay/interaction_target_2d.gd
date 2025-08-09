extends Area2D
class_name InteractionTarget2D

signal targeted(bool)
signal interacted(InteractionOrigin2D)

func interact(origin: InteractionOrigin2D) -> void:
	interacted.emit(origin)
