extends Interactable

export(String) var Function = ""
export(String) var FuncText = ""
export(String) var Arg1 = ""
export(int) var Arg2 = 0
export(Vector3) var Arg3
export(String) var Arg4 = ""

onready var player = get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player")
onready var Narrator = get_node("/root/SceneManager/GameScene/GameViewport/world/Narrator")
var Interacted = true

func get_interaction_text():
	return str("Press E to " + FuncText)

func interact():
	if Interacted:
		
		match Function:
			"scene":
				pass
			"wyoming":
				player.transform.origin = Arg3
				if AchievementsHolder.game_data.Wyoming == 0:
					AchievementsHolder.game_data.Wyoming = 1
					AchievementsHolder._save()
					AchievementsHolder.emit_signal("NewAchievement")
			"pos":
				player.transform.origin = Arg3
			"die":
				SceneManager._reload_scene()
			"continue":
				RoomLoader._get_next_room()
			"delete":
				get_node(Arg1).queue_free()
			"delete2":
				get_node(Arg1).queue_free() 
				get_node(Arg4).queue_free()
			"summon_monster":
				var FairyEnemy = preload("res://scenes/enemies/FairyEnemy.tscn")
				get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/wall").queue_free() # /root/SceneManager/GameScene/GameViewport/world/RoomItems/
				var FairyEnemy2 = FairyEnemy.instance()
				FairyEnemy2.transform.origin = Arg3
				get_node("/root/SceneManager/GameScene/GameViewport/world/").add_child(FairyEnemy2)
				get_node("/root/SceneManager/GameScene/GameViewport/world/FairyEnemy")._change_state(2)
				Narrator.messages = [str(Arg1), ""]
				Narrator.start_dialogue()
			"health_set":
				SaveGame.game_data.PlayerHP = Arg2
			"health_add":
				SaveGame.game_data.PlayerHP += Arg2
				if SaveGame.game_data.PlayerHP > 100:
					SaveGame.game_data.PlayerHP = 100
		$ButtonNoise.pitch_scale = rand_range(0.80, 1.2)
		$ButtonNoise.play()
		Interacted = false
