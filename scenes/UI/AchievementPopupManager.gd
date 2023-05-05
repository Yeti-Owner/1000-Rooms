extends Control


func _ready():
# warning-ignore:return_value_discarded
	AchievementsHolder.connect("NewAchievement", self, "_achievement")

func _achievement():
	$AnimationPlayer.play("Achievement")
