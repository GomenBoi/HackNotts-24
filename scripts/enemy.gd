extends Area2D

@onready var projectile_timer = $Timer
@onready var projectile_scene = preload("res://scenes/fire_projectile.tscn")
@onready var root : Node = get_tree().get_root().get_child(2)
@onready var Player : CharacterBody2D = root.get_node("CharacterBody2D")

var is_in_range = false
var health = 3

func _ready() -> void:
	# Plays idle animation and connects timeout function for spawning projectiles
	$AnimatedSprite2D.play("idle")
	projectile_timer.connect("timeout", on_timeout)
	projectile_timer.start()

func _physics_process(delta: float) -> void:
	if (Player.global_position - global_position).length() < 300:
		is_in_range = true
	else:
		is_in_range = false
	
func on_timeout() -> void:
	if not is_in_range:
		return
		
	var instance : FireProjectile = projectile_scene.instantiate()
	instance.global_position = global_position
	var dir = (Player.global_position - global_position).normalized()
	instance.global_rotation = dir.angle() + PI / 2.0
	instance.z_index = Player.z_index + 1
	instance.initial_direction = dir
	
	root.call_deferred("add_child", instance)
	
func on_body_entered(body: Node2D):
	print(body)
	
	

	
