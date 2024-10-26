extends CharacterBody2D

var main = load("res://scenes/root.tscn")
var projectile = load("res://scenes/flame.tscn")

var onCD = false

func shoot():
	var instance = projectile.instantiate()
	instance.direction = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	instance.zdex = z_index - 1
	main.add_child.call_deferred(instance)

func _physics_process(delta: float) -> void:
	var attack = Input.get_action_raw_strength("Attack")
	
	if attack && !onCD:
		shoot()
