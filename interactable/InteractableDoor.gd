extends Interactable

onready var AnimPlayer = get_parent().get_node("Door2/Door2/AnimationPlayer")
onready var fader = get_parent().get_parent()
onready var DoorSound = get_parent().get_node("Door2/Door2/DoorSound")
var InteractedWith = 0

func _ready():
	fader.connect("fade_finished", self, "on_fade_finished")

func get_interaction_text():
	return "Press E to open the door"

func interact():
	AnimPlayer.play("opening")
	DoorSound.pitch_scale = rand_range(0.85, 1.15)
	DoorSound.play()
	fader._fade_out()
	InteractedWith = 1

func on_fade_finished():
	if InteractedWith:
		RoomLoader._get_next_room()

