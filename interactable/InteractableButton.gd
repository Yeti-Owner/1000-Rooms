extends Interactable

@export var Function: String = ""
@export var FuncText: String = ""
@export var Arg1: NodePath
@export var Arg2: int := 0

@onready var player := get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player")
@onready var Narrator := get_node("/root/SceneManager/GameScene/GameViewport/world/Narrator")
var Interacted := false

func get_interaction_text():
	return str("Press %s to %s" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode), FuncText])

func interact():
	if Interacted == true:
		return
	match Function:
		"wyoming":
			player.transform.origin = Vector3(-55, 2, -38)
			if AchievementsHolder.game_data.Wyoming == 0:
				AchievementsHolder.game_data.Wyoming = 1
				AchievementsHolder._save()
				AchievementsHolder.emit_signal("NewAchievement")
		"die":
			SceneManager._reload_scene()
		"continue":
			RoomLoader._get_next_room()
		"delete":
			if has_node(Arg1): get_node(Arg1).queue_free()
		"fairy":
			var FairyEnemy = load("res://scenes/enemies/FairyEnemy.tscn").instantiate()
			get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/wall").queue_free()
			FairyEnemy.transform.origin = Vector3(-5, 1, 3)
			get_node("/root/SceneManager/GameScene/GameViewport/world/").add_child(FairyEnemy)
			get_node("/root/SceneManager/GameScene/GameViewport/world/FairyEnemy")._change_state(2)
			Narrator.messages = ["The fairy is loose!", "find where it came from to escape"]
			Narrator.start_dialogue()
		"hp":
			SaveGame.game_data.PlayerHP = Arg2
			Settingsholder.emit_signal("hp_changed")
	$ButtonNoise.pitch_scale = randf_range(0.80, 1.2)
	$ButtonNoise.play()
	Interacted = true
