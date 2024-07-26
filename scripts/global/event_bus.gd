extends Node

# Save Data
const save_location:String = "user://save.dat"

func _ready():
	if FileAccess.file_exists(save_location):
		_load()
	else:
		_save()

# advantage of this is to create objects outside the scene 
# and do loading without default change scene function
func _change_scene(current_scene:Node, scene_path:String):
	print("Changing scene from: ", current_scene, " to: ", scene_path)
	
	# remove current scene
	current_scene.queue_free()
	
	# load scene based off path
	var s := load(scene_path)
	var _s = s.instantiate()
	get_node("/root/").add_child(_s)

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
