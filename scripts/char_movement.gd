extends CharacterBody2D

var speed

@export var DEFAULT_SPEED : int
@export var SPRINT_SPEED : int

var TOTAL_JUMPS = 2
var current_jumps = 2

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export var tfliph = false

var jumping = false
var onAttackCD = false

@onready var main = get_tree().get_root().get_child(0)
#@onready var projectile = preload("res://scenes/flame.tscn")
@onready var projectile = preload("res://scenes/sword.tscn")

func _physics_process(delta: float):
	var left = Input.get_action_strength("Move_Left")
	var right = Input.get_action_strength("Move_Right")
	
	var sprint = Input.get_action_raw_strength("Sprint")
	
	velocity.y += get_gravity2() * delta
	
	if is_on_floor():
		current_jumps = TOTAL_JUMPS
	
	var has_jumped = false
	if Input.is_action_just_pressed("Jump"):
		has_jumped = jump()
		
	if Input.is_action_just_pressed("Attack") && !onAttackCD:
		shoot()
	
	if sprint == 1:
		speed = SPRINT_SPEED
	else:
		speed = DEFAULT_SPEED
	
	var x_direction = right - left
	var x_velocity = speed * x_direction
	
	if x_direction == 0:
		if jumping:
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("idle")
	else:
		if x_direction > 0:
			tfliph = false
			$AnimatedSprite2D.flip_h = false
		else:
			tfliph = true
			$AnimatedSprite2D.flip_h = true
		
		if jumping:
			$AnimatedSprite2D.play("jump")
		elif sprint == 1:
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("walk")
	
	velocity.x = x_velocity
	
	move_and_slide()
	
func get_gravity2() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump() -> bool:
	if current_jumps == TOTAL_JUMPS:
		if is_on_floor():
			velocity.y = jump_velocity
			current_jumps -= 1
			return false
	else:
		if current_jumps > 0:
			velocity.y = jump_velocity
			current_jumps -= 1
			return false
		else:
			current_jumps = TOTAL_JUMPS	
	return true

func shoot():
	var instance = projectile.instantiate()
	var charBody = instance.get_node("CharacterBody2D")
	charBody.direction = rotation
	charBody.spawnPos = global_position
	charBody.spawnRot = rotation
	charBody.zdex = z_index - 1
	charBody.fliph = tfliph
	main.call_deferred("add_child", instance)
	onAttackCD = true
	$AttackCD.start()
	print("ADded child")

func _on_attack_cd_timeout() -> void:
	onAttackCD = false
