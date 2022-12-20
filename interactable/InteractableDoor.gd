extends Interactable

onready var AnimPlayer = get_parent().get_node("Door2/Door2/AnimationPlayer")
onready var DoorSound = get_parent().get_node("Door2/Door2/DoorSound")
var InteractedWith = 0

func get_interaction_text():
	return "Press %s to open the door" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	AnimPlayer.play("opening")
	DoorSound.pitch_scale = rand_range(0.85, 1.15)
	DoorSound.play()
	SaveGame.emit_signal("EnemyPassive")
	if InteractedWith == 0:
		RoomLoader._get_next_room()
	InteractedWith = 1

