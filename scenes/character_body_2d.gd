extends CharacterBody2D

var speed

var DEFAULT_SPEED = 300
var SPRINT_SPEED = 600

func _physics_process(delta: float):
	var left = Input.get_action_strength("Move_Left")
	var right = Input.get_action_strength("Move_Right")
	
	var sprint = Input.get_action_raw_strength("Sprint")
	
	if sprint == 1:
		speed = SPRINT_SPEED
	else:
		speed = DEFAULT_SPEED
	
	var x_direction = right - left
	var x_velocity = speed * x_direction
	
	velocity = Vector2(x_velocity, 0)
	move_and_slide()
