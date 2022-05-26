extends Interactable

onready var AnimPlayer = get_parent().get_node("AnimationPlayer")

func get_interaction_text():
	return "open the door"

func interact():
	AnimPlayer.play("opening")
	print("work?")
