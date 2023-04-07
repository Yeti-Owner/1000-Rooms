extends Interactable

@export var Door: int = 1

@onready var father = get_parent().get_parent().get_parent().get_parent()

func get_interaction_text():
	match Door:
		1:
			return ("Press %s to choose door A" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)])
		2: 
			return ("Press %s to choose door B" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)])
		3:
			return ("Press %s to choose door C" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)])

func interact():
	if father.DoorStage == 1:
		father._first_door(Door)
		father.DoorStage += 1
	elif father.DoorStage == 2:
		father._second_door(Door)
		father.DoorStage += 1
