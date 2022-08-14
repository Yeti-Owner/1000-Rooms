extends Interactable

func get_interaction_text():
	return "Press E to find Xavier Renegade Angel"

func interact():
	SaveGame.game_data.PlayerHP = 100
	if AchievementsHolder.game_data.Ufrz == 0:
			AchievementsHolder.game_data.Ufrz = 1
			AchievementsHolder._save()
			AchievementsHolder.emit_signal("NewAchievement")
