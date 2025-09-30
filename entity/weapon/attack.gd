extends Node2D
class_name Attack

@export var speed: float = 1.0
@export var damage: int = 0
## Can be set to -1 for infinite pierce
@export var pierce := 1

var direction: Vector2 = Vector2.RIGHT
var hitboxes: Array[ShapeCast2D]

func _ready() -> void:
	for c in get_children():
		if c is ShapeCast2D:
			hitboxes.push_back(c)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	for hitbox in hitboxes:
		hitbox.target_position = direction * speed * delta
		
		for result in hitbox.collision_result:
			# Manually cast because it could be an obstacle
			hit(hitbox, result.collider as Entity2D)
			if not pierce:
				queue_free()
				break

func hit(hitbox: ShapeCast2D, entity: Entity2D) -> void:
	hitbox.add_exception(entity)
	# If the node is not an entity, the attack should be stopped
	if !entity:
		pierce = 0
		return
	pierce -= 1
	entity.damage(damage)

func timeout() -> void:
	queue_free()
