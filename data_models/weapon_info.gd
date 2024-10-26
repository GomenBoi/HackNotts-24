extends Node

var cache
var weaponsData = "res://config/weapons_config.json"

func _ready() -> void:
	var file = FileAccess.open(weaponsData, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	cache = json.parse_string(content).weapons

func getWeaponsData(weapon : String):
	for object in cache:
		if object.name == weapon:
			return object
