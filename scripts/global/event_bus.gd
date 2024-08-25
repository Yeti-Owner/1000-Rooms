extends Node

# Signals
@warning_ignore("unused_signal")
signal interaction(icon, text)

# Settings
var player_sensitivity:float = 0.12
const default_crosshair := "res://assets/ui/default_crosshair.png"
const interact_crosshair := "res://assets/ui/interact_crosshair.png"

# Save Data
const save_location:String = "user://save.dat"

func _ready():
	if FileAccess.file_exists(save_location):
		_load()
	else:
		_save()

func _save():
	var file := FileAccess.open(save_location, FileAccess.WRITE)
	var saved_data:Dictionary = {
		"PLACEHOLDER" : "placeholder"
	}
	file.store_var(saved_data)

func _load():
	var file := FileAccess.open(save_location, FileAccess.READ)
	var new_data = file.get_var()
	# var = new_data.VAR

func _quit(code:int = 0):
	match code:
		0:
			_save()
	get_tree().quit()
