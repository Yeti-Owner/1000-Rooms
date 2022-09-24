extends Interactable

onready var AnimPlayer = get_parent().get_node("Door2/Door2/AnimationPlayer")
onready var DoorSound = get_parent().get_node("Door2/Door2/DoorSound")
var InteractedWith = 0

func get_interaction_text():
	return "Press E to open the door"

func interact():
	AnimPlayer.play("opening")
	DoorSound.pitch_scale = rand_range(0.85, 1.15)
	DoorSound.play()
	if InteractedWith == 0:
		RoomLoader._get_next_room()
	InteractedWith = 1

