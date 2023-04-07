extends Interactable

var InteractedWith = 0
signal PipeEntered

func _ready():
# warning-ignore:return_value_discarded
	SceneManager.connect("FakeFadeDone",Callable(self,"on_fade_finished"))

func get_interaction_text():
	return "Press %s to enter the pipe" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)]

func interact():
	SceneManager._fake_fade()

func on_fade_finished():
	if InteractedWith == 0:
		emit_signal("PipeEntered")
	InteractedWith = 1
