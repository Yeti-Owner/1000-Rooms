extends Interactable

func get_interaction_text():
	return "Press E to use Medkit"

func interact():
	if SaveGame.game_data.PlayerHP <= 80:
		SaveGame.game_data.PlayerHP += 20
		get_parent().queue_free()
	elif SaveGame.game_data.PlayerHP == 100:
		return
	else:
		SaveGame.game_data.PlayerHP = 100
		get_parent().queue_free()

