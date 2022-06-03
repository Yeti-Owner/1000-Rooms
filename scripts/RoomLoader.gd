extends Node

var LastRoom
var GotoRoom
var RoomRNG

func _ready():
	randomize()

func _get_next_room():
	LastRoom = Settingsholder.CurrentRoom
	if Settingsholder.RoomNum < 99:
		RoomRNG = randi() % 15 + 1
		GotoRoom = str("res://scenes/rooms/100/room" + str(RoomRNG) + ".tscn")
		if GotoRoom != LastRoom:
			var _error = get_tree().change_scene(GotoRoom)
			Settingsholder.RoomNum += 1
		else: 
			_get_next_room()
	elif (Settingsholder.RoomNum >= 99):
		get_tree().change_scene("res://scenes/EndScreen.tscn")
