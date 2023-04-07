extends Interactable

func get_interaction_text():
	return "Press %s to collect Lin Fei Poster" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)]

func interact():
	$AudioStreamPlayer3D.play()
	if AchievementsHolder.game_data.Shai == 0:
			AchievementsHolder.game_data.Shai = 1
			AchievementsHolder._save()
			AchievementsHolder.emit_signal("NewAchievement")
