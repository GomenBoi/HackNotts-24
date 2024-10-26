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
			$AnimatedSprite2D.flip_h = false
		else:
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
