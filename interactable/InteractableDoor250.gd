extends Interactable

export(int) var Door = 1

func get_interaction_text():
	match Door:
		1:
			return "Press E to choose door A"
		2: 
			return "Press E to choose door B"
		3:
			return "Press E to choose door C"

func interact():
	if get_parent().get_parent().get_parent().get_parent().DoorStage == 1:
		get_parent().get_parent().get_parent().get_parent()._first_door(Door)
		get_parent().get_parent().get_parent().get_parent().DoorStage += 1
	elif get_parent().get_parent().get_parent().get_parent().DoorStage == 2:
		get_parent().get_parent().get_parent().get_parent()._second_door(Door)
		get_parent().get_parent().get_parent().get_parent().DoorStage += 1
