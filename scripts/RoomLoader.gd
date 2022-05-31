extends Node

var LastRoom
var GotoRoom
var RoomRNG

func _ready():
	randomize()

func _get_next_room():
	LastRoom = Settingsholder.CurrentRoom
	if Settingsholder.RoomNum < 99:
		RoomRNG = randi() % 10 + 1
		GotoRoom = str("res://scenes/rooms/100/room" + str(RoomRNG) + ".tscn")
		if GotoRoom == LastRoom:
			_get_next_room()
	elif Settingsholder.RoomNum >= 99:
		GotoRoom = str("res://scenes/EndScreen.tscn")
	var _error = get_tree().change_scene(GotoRoom)
	Settingsholder.RoomNum += 1
