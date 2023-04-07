extends Interactable

func get_interaction_text():
	return "Press %s to use Medkit" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)]

func interact():
	SaveGame.game_data.PlayerHP = min(100, SaveGame.game_data.PlayerHP+20)
	get_parent().queue_free()
	Settingsholder.emit_signal("hp_changed")

