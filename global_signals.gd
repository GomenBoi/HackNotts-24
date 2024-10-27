extends Node

signal showInfo(name: String)
signal hideInfo

func emit_showInfo(name: String) -> void:
	print("Emitting showInfo with name:", name)
	emit_signal("showInfo", name)

func emit_hideInfo() -> void:
	print("Emitting hideInfo")
	emit_signal("hideInfo")
