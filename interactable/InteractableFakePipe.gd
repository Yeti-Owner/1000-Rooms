extends Interactable

var InteractedWith = 0
signal PipeEntered

func _ready():
# warning-ignore:return_value_discarded
	SceneManager.connect("FakeFadeDone", self, "on_fade_finished")

func get_interaction_text():
	return "Press %s to enter the pipe" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	SceneManager._fake_fade()

func on_fade_finished():
	if InteractedWith == 0:
		emit_signal("PipeEntered")
	InteractedWith = 1
