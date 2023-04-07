extends Interactable
@onready var room = get_parent().get_parent()
var InteractedWith = 0

func get_interaction_text():
	return "Press %s to touch the Rune" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)]

func interact():
	if InteractedWith:
		pass
	else:
		$AnimationPlayer.play("Filling")
		InteractedWith = 1
		room._rune_found()
