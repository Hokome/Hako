extends EntityTop2D
class_name PlayerTop2D

func _physics_process(delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = input
	super(delta)

func send_weapon_input(weapon: Weapon, action_name: String) -> void:
	weapon.point = get_global_mouse_position()
	if Input.is_action_just_pressed(action_name):
		weapon.press()
	if Input.is_action_just_released(action_name):
		weapon.release()
	weapon.held = Input.is_action_pressed(action_name)
