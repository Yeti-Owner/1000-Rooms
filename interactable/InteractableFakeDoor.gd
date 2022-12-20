extends Interactable

onready var AnimPlayer = get_parent().get_node("Door2/Door2/AnimationPlayer")
onready var DoorSound = get_parent().get_node("Door2/Door2/DoorSound")
onready var Player = get_parent().get_parent().get_node("Player")
var InteractedWith = 0

signal DoorOpened

func _ready():
# warning-ignore:return_value_discarded
	SceneManager.connect("FakeFadeDone", self, "on_fade_finished")

func get_interaction_text():
	return "Press %s to open the door" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	AnimPlayer.play("opening")
	DoorSound.pitch_scale = rand_range(0.85, 1.15)
	SceneManager._fake_fade()
	DoorSound.play()
	InteractedWith = 1

func on_fade_finished():
	if InteractedWith:
		emit_signal("DoorOpened")
		AnimPlayer.play("RESET")
		Player.transform.origin = Vector3(0, 0.7, -42.3)
		InteractedWith = 0

