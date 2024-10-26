extends CharacterBody2D

@export var SPEED : int

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _physics_process(delta: float):
	# Gets input from right/left keys and moves character at constant speed
	var x_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var x_velocity = x_direction * SPEED
	
	velocity.y += get_gravity2() * delta
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
	
	var y_direction 
	velocity.x = x_velocity
	
	move_and_slide()
	
func get_gravity2() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
