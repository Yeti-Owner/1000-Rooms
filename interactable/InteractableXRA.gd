extends Interactable

func get_interaction_text():
	return "Press %s to find Xavier Renegade Angel" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	SaveGame.game_data.PlayerHP = 100
	if AchievementsHolder.game_data.Ufrz == 0:
			AchievementsHolder.game_data.Ufrz = 1
			AchievementsHolder._save()
			AchievementsHolder.emit_signal("NewAchievement")
