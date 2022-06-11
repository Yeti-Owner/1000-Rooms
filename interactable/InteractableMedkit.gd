extends Interactable

func get_interaction_text():
	return "Press E to use Medkit"

func interact():
	if Settingsholder.PlayerHP <= 80:
		Settingsholder.PlayerHP += 20
		get_parent().queue_free()
	elif Settingsholder.PlayerHP == 100:
		return
	else:
		Settingsholder.PlayerHP = 100
		get_parent().queue_free()

