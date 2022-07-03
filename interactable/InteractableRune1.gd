extends Interactable
onready var room = get_node("/root/world")
var InteractedWith = 0

func get_interaction_text():
	return "Press E to touch the Rune"

func interact():
	if InteractedWith:
		pass
	else:
		$AnimationPlayer.play("Filling")
		InteractedWith = 1
		room._rune_found()
