extends Control

func _ready() -> void:
	print("Control _ready() is running")
	showToolInfo("sword")
	#GlobalSignals.connect("showInfo", Callable(self, "showToolInfo"))
	##GlobalSignals.connect("showInfo", showToolInfo)
	#GlobalSignals.connect("hideInfo", Callable(self, "stopShowingToolInfo"))
	##GlobalSignals.connect("hideInfo", stopShowingToolInfo)
	#print("Connected to GlobalSignals")


func showToolInfo(name : String):
	print("CALLED")
	var cache = WeaponInfo.getWeaponsData(name)
	if !cache: return

	
	$VBoxContainer/ToolName.text = cache.name
	$VBoxContainer/Rarity.text = "Rarity: " + cache.rarity
	$VBoxContainer/Damage.text = "Damage: " + cache.damage
	$VBoxContainer/AttackCD.text = "AttackCD: " + cache.attackcd
	$VBoxContainer/Desc.text = cache.description
	
	visible = true

func stopShowingToolInfo():
	print("LEFT RRCEIVED")
	visible = false
