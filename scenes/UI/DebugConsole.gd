extends Control

var isActive = 0

# Called when the node enters the scene tree for the first time.
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
	if cmd[0] == "print":
		print(cmd[1])
	if cmd[0] == "goto":
		get_tree().change_scene(str("res://scenes/rooms/100/room" + cmd[1] + ".tscn"))
		# res://scenes/rooms/100/room1.tscn
	if cmd[0] == "room":
		Settingsholder.RoomNum = int(cmd[1])
	
