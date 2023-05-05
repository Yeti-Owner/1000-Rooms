extends Spatial

onready var EnemySpawner := get_parent().get_node("NavMesh2/EnemySpawner")
onready var Player := get_parent().get_node("RoomItems/Player")

func _on_Sensor_PlayerDetected():
	# Spawn Ghost
	EnemySpawner._summon()

func _on_Sensor2_PlayerDetected():
	# move player
	Player.global_transform.origin.x += 44
	if AchievementsHolder.game_data.Hell == 0:
			AchievementsHolder.game_data.Hell = 1
			AchievementsHolder._save()
			AchievementsHolder.emit_signal("NewAchievement")

func _on_Sensor3_PlayerDetected():
	if AchievementsHolder.game_data.IQTest == 0:
			AchievementsHolder.game_data.IQTest = 1
			AchievementsHolder._save()
			AchievementsHolder.emit_signal("NewAchievement")
