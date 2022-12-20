extends Interactable

var InteractedWith = 0

func get_interaction_text():
	return "Press %s to enter the pipe" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	if InteractedWith == 0:
		RoomLoader._get_next_room()
	InteractedWith = 1
