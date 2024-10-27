extends TextureButton

var weaponType : String

func _ready() -> void:
	weaponType = "sword"

func _on_mouse_entered() -> void:
	print("ENTERED")
	GlobalSignals.emit_showInfo(weaponType)

func _on_mouse_exited() -> void:
	print("LEFT")
	GlobalSignals.emit_hideInfo()
