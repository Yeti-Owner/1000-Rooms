extends Interactable
onready var room = get_parent().get_parent()
var InteractedWith = 0

func get_interaction_text():
	return "Press %s to touch the Rune" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	if InteractedWith:
		pass
	else:
		$AnimationPlayer.play("Filling")
		InteractedWith = 1
		room._rune_found()
