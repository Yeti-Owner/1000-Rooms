extends Interactable

onready var AnimPlayer = get_parent().get_node("AnimationPlayer")
onready var HatchSound = get_parent().get_node("HatchSound")
var InteractedWith = 0

func get_interaction_text():
	return "Press %s to open the hatch" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	HatchSound.play()
	AnimPlayer.play("open")
	SaveGame.emit_signal("EnemyPassive")
	if InteractedWith == 0:
		RoomLoader._get_next_room()
	InteractedWith = 1
