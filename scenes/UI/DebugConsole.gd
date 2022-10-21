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
		"GH":
			match cmd[1]:
				"print":
					print(cmd[2])
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
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
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				"hp?":
					print(SaveGame.game_data.PlayerHP)
				"scare?":
					print(SaveGame.game_data.JumpScareAmt)
				"scare": 
					SaveGame.game_data.JumpScareAmt = int(cmd[2])
				"rc":
					print(SaveGame.game_data.CurrentRoom)
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
				"deaths":
					print(SaveGame.game_data.Deaths)
		
		"close":
			self.set_visible(false)
			Input.set_mouse_mode(MouseMode)
		"stuck":
			SceneManager._reload_scene()
