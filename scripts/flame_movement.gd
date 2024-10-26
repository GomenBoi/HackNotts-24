extends CharacterBody2D

@export var SPEED = 100

var direction : float = 0.0
var spawnPos : Vector2 = Vector2(0,0)
var spawnRot : float = 0.0
var zdex : int = 1

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	z_index = zdex
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(SPEED, 0).rotated(direction)
	move_and_slide()

func _on_area_2d_body_entered(body):
	print("HIT!")
	# Hit handler function here
	queue_free()
	
func _on_life_timeout():
	print("Projectile life ended")
	queue_free()
