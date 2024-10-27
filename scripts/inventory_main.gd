extends Control

var invOpen = false

func _physics_process(delta: float) -> void:
	var toggleInv = Input.is_action_just_pressed("Inventory")
	
	if toggleInv:
		invOpen = !invOpen
		$CanvasLayer/MarginContainer/TextureRect.visible = invOpen
