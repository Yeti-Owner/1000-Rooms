extends Control

var isActive = 0
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
	match cmd[0]:
		"b":
			match cmd[1]:
				"goto":
					SceneManager._change_scene(str(cmd[2]))
					self.set_visible(false)
					Input.set_mouse_mode(MouseMode)
				"room":
					SaveGame.game_data.RoomNum = int(cmd[2])
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				"hp":
					SaveGame.game_data.PlayerHP = int(cmd[2])
					Settingsholder.emit_signal("hp_changed")
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				"skip50":
					get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player").transform.origin = Vector3(0,5.5,-60)
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				"tmp":
					SceneManager._change_scene("res://ShowcaseWorld.tscn")
				"skip150":
					get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player").transform.origin = Vector3(81.7,5.8,-28)
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		"close":
			self.set_visible(false)
			Input.set_mouse_mode(MouseMode)
		"menu":
			SceneManager._change_scene("res://scenes/StartMenuScene.tscn")
			self.set_visible(false)
		"stuck":
			SceneManager._reload_scene()
			self.set_visible(false)
			Input.set_mouse_mode(MouseMode)
		"blasters":
			if cmd[1] == "are" and cmd[2] == "ass":
				AchievementsHolder.game_data.NotoLotta = 1
				AchievementsHolder._save()
				AchievementsHolder.emit_signal("NewAchievement")
