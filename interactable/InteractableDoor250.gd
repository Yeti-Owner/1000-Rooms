extends Interactable

export(int) var Door = 1

onready var father = get_parent().get_parent().get_parent().get_parent()

func get_interaction_text():
	match Door:
		1:
			return ("Press %s to choose door A" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)])
		2: 
			return ("Press %s to choose door B" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)])
		3:
			return ("Press %s to choose door C" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)])

func interact():
	if father.DoorStage == 1:
		father._first_door(Door)
		father.DoorStage += 1
	elif father.DoorStage == 2:
		father._second_door(Door)
		father.DoorStage += 1
