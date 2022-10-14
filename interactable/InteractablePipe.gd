extends Interactable

var InteractedWith = 0

func get_interaction_text():
	return "Press E to enter the pipe"

func interact():
	if InteractedWith == 0:
		RoomLoader._get_next_room()
	InteractedWith = 1
