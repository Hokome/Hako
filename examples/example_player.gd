extends PlayerTop2D
class_name ExamplePlayer

@onready var weapon := $weapon

func _physics_process(delta: float) -> void:
	super(delta)
	send_weapon_input(weapon, "use")
