extends Interactable

onready var AnimPlayer = get_parent().get_node("Door2/Door2/AnimationPlayer")
onready var fader = get_parent().get_parent()
onready var DoorSound = get_parent().get_node("Door2/Door2/DoorSound")
onready var Player = get_node("/root/world/Fader/Player")
var InteractedWith = 0

signal DoorOpened

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
		emit_signal("DoorOpened")
		AnimPlayer.play("RESET")
		Player.transform.origin = Vector3(0, 0.7, -42.3)
		InteractedWith = 0

