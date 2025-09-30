extends Weapon
class_name DefaultWeapon

@export var projectile_scene: PackedScene

@export var speed := PipeValue.new()
@export var count := PipeValue.from_base_int(1)
@export var pierce := PipeValue.from_base_int(1)

@export var spread := PipeValue.new()
@export var variation := PipeValue.new()

var time_passed: float = INF

func _physics_process(delta: float) -> void:
	time_passed += delta
	if held and cooldown.computef() < time_passed:
		shoot()

func shoot() -> void:
	time_passed = 0.0
	
	var s := spread.computef()
	var c := count.computei()
	
	var base := s * -0.5
	var step := s / c
	var hvar := variation.computef() * 0.5
	
	for i in c:
		var projectile := spawn_attack(projectile_scene)
		projectile.global_position = global_position
		projectile.direction = aim().rotated(deg_to_rad(base + i * step + randf_range(-hvar, hvar)))
		
		projectile.speed = speed.computef()
		projectile.damage = damage.computei()
		time_passed = 0
