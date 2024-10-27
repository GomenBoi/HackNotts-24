extends CharacterBody2D
class_name FireProjectile

@onready var area2D : Area2D = $Area2D
@export var PROJECTILE_SPEED : int
var initial_direction : Vector2

func _ready() -> void:
	# Plays idle animation
	$AnimatedSprite2D.play("idle")
	area2D.connect("body_entered", on_body_entered)
	
func _physics_process(delta: float) -> void:
	# Fires the projectile towards the player using "direction_to" vector
	velocity.x = initial_direction.x * PROJECTILE_SPEED
	velocity.y = initial_direction.y * PROJECTILE_SPEED
	
	move_and_slide()
	
func on_body_entered(body: Node2D) -> void:
	# Checks if colliding body has method "on_hit", exclusive to player
	if body.is_in_group("projectile_collidable"):
		if body.has_method("on_hit"):
			body.on_hit(self)
		queue_free()
