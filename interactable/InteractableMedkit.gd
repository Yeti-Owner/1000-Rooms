extends Interactable

func get_interaction_text():
	return "Press %s to use Medkit" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	SaveGame.game_data.PlayerHP = min(100, SaveGame.game_data.PlayerHP+20)
	get_parent().queue_free()
	Settingsholder.emit_signal("hp_changed")

