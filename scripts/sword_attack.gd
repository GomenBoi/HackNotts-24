extends flame_projectile

func loadData():
	var weaponData = WeaponInfo.getWeaponsData("sword")
	SPEED = weaponData.speed
	protation = weaponData.rotation
	$LifeTime.wait_time = weaponData.lifetime

func _physics_process(delta: float) -> void:
	if fliph:
		velocity = Vector2(-SPEED, 0).rotated(direction)
	else:
		velocity = Vector2(SPEED, 0).rotated(direction)
		
	move_and_slide()

func _process(delta: float) -> void:
	rotation += protation
