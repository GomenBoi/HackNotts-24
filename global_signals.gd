extends Node

signal showInfo(name: String)
signal hideInfo

func emit_showInfo(name: String) -> void:
	print("Emitting showInfo with name:", name)
	emit_signal("showInfo", name)

func emit_hideInfo() -> void:
	print("Emitting hideInfo")
	emit_signal("hideInfo")


var currentWeapon = "flame"
func getPlayerWeapon():
	return currentWeapon
	
func setNewPlayerWeapon(weapon : String):
	if weapon == "flame" or weapon == "sword":
		currentWeapon = weapon
		
var playersWeapons = []	
@onready var inventory = get_node("res://scenes/inventory.tscn")
var swordBTN = preload("res://scenes/Inv_buttons/weapon_sword.tscn")
var flameBTN = preload("res://scenes/Inv_buttons/weapon_flame.tscn")
func awardWeapon(weapon : String):
	var hasWeapon = false
	for i in playersWeapons:
		if i == weapon: 
			hasWeapon = true
			break
	if !hasWeapon:
		playersWeapons.append(weapon)
		
		var newBTN
		if(weapon) == "sword":
			newBTN = swordBTN.instantiate()
		else:
			newBTN = flameBTN.instantiate()
			
		inventory.call_deferred("add_child", newBTN)
