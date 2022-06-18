extends Interactable

export(String) var Function = ""
export(String) var FuncText = ""
export(String) var Arg1 = ""
export(int) var Arg2 = 0
export(Vector3) var Arg3
export(String) var Arg4 = ""

onready var player = get_node("/root/world/Fader/Player")
func get_interaction_text():
	return str("Press E to " + FuncText)

func interact():
	match Function:
		"scene":
			pass
		"pos":
			player.transform.origin = Arg3
		"die":
			get_tree().reload_current_scene()
		"continue":
			RoomLoader._get_next_room()
		"delete":
			get_node(Arg1).queue_free()
		"delete2":
			get_node(Arg1).queue_free()
			get_node(Arg4).queue_free()
		"summon_monster":
			pass
