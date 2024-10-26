extends StaticBody2D

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	
func _physics_process(delta: float) -> void:
	pass
	
