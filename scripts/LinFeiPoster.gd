extends Interactable

func get_interaction_text():
	return "Press E to collect Lin Fei Poster"

func interact():
	$AudioStreamPlayer3D.play()
	if AchievementsHolder.game_data.Shai == 0:
			AchievementsHolder.game_data.Shai = 1
			AchievementsHolder._save()
			AchievementsHolder.emit_signal("NewAchievement")
