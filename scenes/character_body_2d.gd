extends CharacterBody2D

var speed

var DEFAULT_SPEED = 300
var SPRINT_SPEED = 600

var JUMP_HEIGHT = 50
var JUMP_TIME = 1
var JUMP_CD = 2

var jump_velocity = (5 * JUMP_HEIGHT) / (JUMP_TIME * -1)
var fall_gravity = (-5 * JUMP_HEIGHT) / (JUMP_TIME * JUMP_TIME * -1)

var tfliph = false

var jumping = false
var jump_count

func _physics_process(delta: float):
	var left = Input.get_action_strength("Move_Left")
	var right = Input.get_action_strength("Move_Right")
	
	var sprint = Input.get_action_raw_strength("Sprint")
	
	var jump = Input.get_action_raw_strength("Jump")
	
	jumping = false
	if jump == 1:
		jumping = true
	
	
	
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
	velocity.y += fall_gravity * delta
	
	if jumping:
		velocity.y = jump_velocity
	
	move_and_slide()


var jumpCount = 0
