extends Area2D
class_name InteractionSource2D

@export var indicator_scene: PackedScene
var indicator: InteractionIndicator2D

var targets: Array[InteractionTarget2D]
var selected: InteractionTarget2D:
	set(val):
		if selected == val:
			return
		
		if selected:
			selected.deselect(self)
		
		selected = val
		if selected:
			selected.select(self)

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
	indicator = indicator_scene.instantiate()
	indicator.owning_source = self
	add_child(indicator)

func _physics_process(_delta: float) -> void:
	selected = select_target()

func _unhandled_input(event: InputEvent) -> void:
	if !event.is_pressed() or event.is_echo():
		return
	
	if event.is_action("interact"):
		if selected:
			selected.interact(self)

func select_target() -> InteractionTarget2D:
	var closest: InteractionTarget2D = null
	var closest_distance := INF
	
	for target in targets:
		var distance := target.global_position.distance_squared_to(global_position)
		if distance < closest_distance:
			closest = target
			closest_distance = distance
	
	return closest

func _on_area_entered(area: Area2D) -> void:
	if area is InteractionTarget2D:
		targets.push_back(area)

func _on_area_exited(area: Area2D) -> void:
	targets.erase(area)
