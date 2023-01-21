extends Control

var isActive:bool = false
var MouseMode

func _ready():
	self.set_visible(false)

func _unhandled_input(event):
	if event.is_action_pressed("console"):
		isActive = !isActive
		if isActive:
			MouseMode = Input.get_mouse_mode()
			self.set_visible(true)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			self.set_visible(false)
			Input.set_mouse_mode(MouseMode)

func _on_console_text_entered(cmd):
	cmd = cmd.split(" ")
	for i in cmd.size():
		cmd[i] = cmd[i].to_lower()
	match cmd[0]:
		"po":
			match cmd[1]:
				"goto":
					SceneManager._change_scene(str(cmd[2]))
					_close()
				"room":
					SaveGame.game_data.RoomNum = int(cmd[2])
					_close()
				"hp":
					SaveGame.game_data.PlayerHP = int(cmd[2])
					Settingsholder.emit_signal("hp_changed")
					_close()
				"skip50":
					get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player").transform.origin = Vector3(0,5.5,-60)
					_close()
				"tmp":
					SceneManager._change_scene("res://ShowcaseWorld.tscn")
					_close()
				"skip150":
					get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player").transform.origin = Vector3(81.7,5.8,-28)
					_close()
		"close":
			_close()
		"menu":
			SceneManager._change_scene("res://scenes/StartMenuScene.tscn")
			_close()
		"stuck":
			SceneManager._reload_scene()
			_close()
		"blasters":
			if cmd[1] == "are" and cmd[2] == "ass":
				AchievementsHolder.game_data.NotoLotta = 1
				AchievementsHolder._save()
				AchievementsHolder.emit_signal("NewAchievement")
				_close()

func _close():
	self.set_visible(false)
	Input.set_mouse_mode(MouseMode)
