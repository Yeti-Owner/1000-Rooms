extends Interactable

export(int) var Door = 1
#onready var InteractStage = get_node("/root/world").DoorStage

func get_interaction_text():
	match Door:
		1:
			return "Press E to choose door A"
		2: 
			return "Press E to choose door B"
		3:
			return "Press E to choose door C"

func interact():
	if get_node("/root/world").DoorStage == 1:
		get_node("/root/world")._first_door(Door)
		get_node("/root/world").DoorStage += 1
	elif get_node("/root/world").DoorStage == 2:
		get_node("/root/world")._second_door(Door)
		get_node("/root/world").DoorStage += 1
	else:
		pass
