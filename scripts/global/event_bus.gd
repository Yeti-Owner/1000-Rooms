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

# Misc
var current_scene:Node = null

func _ready():
	if FileAccess.file_exists(save_location):
		_load()
	else:
		_save()

# advantage of this is to create objects outside the scene 
# and do loading without default change scene function
func _change_scene(new_scene:String, current:Node = current_scene):
	if current == null:
		print("Current Scene missing")
		return
	
	print("Changing scene from: ", current, " to: ", new_scene)
	
	# remove current scene
	current.queue_free()
	
	# load scene based off path
	var s := load(new_scene)
	var _s = s.instantiate()
	get_node("/root/").add_child(_s)
	
	current_scene = _s

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
