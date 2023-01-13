extends Interactable

func get_interaction_text():
	return "Press %s to collect Lin Fei Poster" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	$AudioStreamPlayer3D.play()
	if AchievementsHolder.game_data.Shai == 0:
			AchievementsHolder.game_data.Shai = 1
			AchievementsHolder._save()
			AchievementsHolder.emit_signal("NewAchievement")
