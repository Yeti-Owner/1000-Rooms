extends Interactable

export(int) var Door = 1

func get_interaction_text():
	match Door:
		1:
			return ("Press %s to choose door A" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)])
		2: 
			return ("Press %s to choose door B" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)])
		3:
			return ("Press %s to choose door C" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)])

func interact():
	if get_parent().get_parent().get_parent().get_parent().DoorStage == 1:
		get_parent().get_parent().get_parent().get_parent()._first_door(Door)
		get_parent().get_parent().get_parent().get_parent().DoorStage += 1
	elif get_parent().get_parent().get_parent().get_parent().DoorStage == 2:
		get_parent().get_parent().get_parent().get_parent()._second_door(Door)
		get_parent().get_parent().get_parent().get_parent().DoorStage += 1
