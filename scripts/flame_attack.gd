extends CharacterBody2D
class_name flame_projectile

@export var SPEED = 800

var direction : float = 0.0
var spawnPos : Vector2 = Vector2(0,0)
var spawnRot : float = 0.0
var zdex : int = 1
var fliph : bool = false
var protation : float = 0

func _ready():
	loadData()
	global_position = spawnPos
	global_rotation = spawnRot
	z_index = zdex
	$Sprite2D.flip_h = fliph
	
func loadData():
	var weaponData = WeaponInfo.getWeaponsData("flame")
	SPEED = weaponData.speed
	protation = weaponData.rotation
	$LifeTime.wait_time = weaponData.lifetime
	
func _physics_process(delta: float) -> void:
	if fliph:
		velocity = Vector2(-SPEED, 0).rotated(direction)
	else:
		velocity = Vector2(SPEED, 0).rotated(direction)
		
	move_and_slide()

func _on_life_time_timeout() -> void:
	queue_free()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
