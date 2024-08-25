extends Node

@onready var scene_path := {
	"UI" : $UI,
	"GAME" : $Game/Viewport
}

func _ready():
	_change_scene("UI", "res://scenes/ui/main_menu.tscn")
	_change_scene("GAME", "res://scenes/ui/main_menu_display.tscn")

func _change_scene(type:String, new_scene:String):
	if not type in scene_path:
		print("Invalid type")
		
		return
	
	var scene_location = scene_path[type]
	
	# clears old scenes
	for child in scene_location.get_children():
		child.queue_free()
	
	#print("Changing scene to: ", new_scene, " in: ", type)
	
	# load scene based off path
	var s := load(new_scene)
	var _s = s.instantiate()
	scene_location.add_child(_s)
