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
	if cmd[0] == "YY":
		if cmd[1] == "print":
			print(cmd[2])
		elif cmd[1] == "goto":
			var _error = get_tree().change_scene(str(cmd[2] + ".tscn"))
			# res://scenes/rooms/100/room1.tscn
		elif cmd[1] == "room":
			SaveGame.game_data.RoomNum = int(cmd[2])
		elif cmd[1] == "hp":
			SaveGame.game_data.PlayerHP = int(cmd[2])
		elif cmd[1] == "jumpscare?":
			print(SaveGame.game_data.JumpScareAmt)
		elif cmd[1] == "scare":
			SaveGame.game_data.JumpScareAmt = int(cmd[2])
		elif cmd[1] == "rc": # Room Check
			print(SaveGame.game_data.CurrentRoom)
	elif cmd[0] == "close":
		self.set_visible(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif cmd[0] == "stuck":
		var _error = get_tree().reload_current_scene()
