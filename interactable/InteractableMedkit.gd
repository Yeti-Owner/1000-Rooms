extends Interactable

func get_interaction_text():
	return "Press %s to use Medkit" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	if SaveGame.game_data.PlayerHP <= 80:
		SaveGame.game_data.PlayerHP += 20
		get_parent().queue_free()
	elif SaveGame.game_data.PlayerHP == 100:
		return
	else:
		SaveGame.game_data.PlayerHP = 100
		get_parent().queue_free()

