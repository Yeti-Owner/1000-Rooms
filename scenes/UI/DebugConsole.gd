extends Control

var isActive = 0

func _ready():
	self.set_visible(false)

func _unhandled_input(event):
	if event.is_action_pressed("console"):
		isActive = !isActive
		if isActive:
			self.set_visible(true)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			self.set_visible(false)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_console_text_entered(cmd):
	cmd = cmd.split(" ")
	match cmd[0]:
		"UI":
			match cmd[1]:
				"print":
					print(cmd[2])
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				"goto":
					var _error = get_tree().change_scene(str(cmd[2] + ".tscn"))
				"room":
					SaveGame.game_data.RoomNum = int(cmd[2])
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				"hp":
					SaveGame.game_data.PlayerHP = int(cmd[2])
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				"scare?":
					print(SaveGame.game_data.JumpScareAmt)
				"scare": 
					SaveGame.game_data.JumpScareAmt = int(cmd[2])
				"rc":
					print(SaveGame.game_data.CurrentRoom)
				"skip50":
					get_node("/root/world/Fader/Player").transform.origin = Vector3(0,5.5,-60)
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				"tmp":
					var _error = get_tree().change_scene("res://ShowcaseWorld.tscn")
				"skip150":
					get_node("/root/world/Fader/Player").transform.origin = Vector3(81.7,5.8,-28)
					self.set_visible(false)
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

		"close":
			self.set_visible(false)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		"stuck":
			var _error = get_tree().reload_current_scene()
