extends Interactable

onready var AnimPlayer = get_parent().get_node("AnimationPlayer")
onready var fader = get_parent().get_parent().get_parent().get_parent()
var InteractedWith = 0

func _ready():
	fader.connect("fade_finished", self, "on_fade_finished")

func get_interaction_text():
	return "open the door"

func interact():
	AnimPlayer.play("opening")
	fader._fade_out()
	InteractedWith = 1

func on_fade_finished():
	if InteractedWith:
		RoomLoader._get_next_room()
