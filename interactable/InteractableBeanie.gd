extends Interactable

func _ready():
	if AchievementsHolder.game_data.Badenov == 1:
		self.queue_free()

func get_interaction_text():
	return "Press E to collect Beanie"

func interact():
	if AchievementsHolder.game_data.Badenov == 0:
		AchievementsHolder.game_data.Badenov = 1
		AchievementsHolder._save()
		AchievementsHolder.emit_signal("NewAchievement")
		self.queue_free()
