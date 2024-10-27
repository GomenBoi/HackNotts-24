extends Camera2D

@onready var root : Node = get_tree().get_root().get_child(2)
@onready var Player : CharacterBody2D = root.get_node("CharacterBody2D")

func _process(delta: float) -> void:
	var current_player_y = Player.global_position.y
	if current_player_y > 0 :
		offset.y = 240
	elif current_player_y < 0 && current_player_y > -240:
		offset.y = 0
	elif current_player_y < -240 && current_player_y > -480:
		offset.y = -240
	elif current_player_y < -480 && current_player_y > -720:
		offset.y = -720
