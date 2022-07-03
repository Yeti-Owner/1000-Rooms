extends Node

var LastRoom
var GotoRoom
var RoomRNG

func _ready():
	randomize()

func _get_next_room():
	LastRoom = SaveGame.game_data.CurrentRoom
	if (SaveGame.game_data.RoomNum == 49):
		SaveGame.game_data.RoomNum += 1
		var _error = get_tree().change_scene("res://scenes/rooms/100/room50.tscn")
	if (SaveGame.game_data.RoomNum == 74):
		var _error = get_tree().change_scene("res://scenes/rooms/100/room75.tscn")
	elif SaveGame.game_data.RoomNum < 99:
		RoomRNG = randi() % 15 + 1
		GotoRoom = str("res://scenes/rooms/100/room" + str(RoomRNG) + ".tscn")
		if GotoRoom != LastRoom:
			var _error = get_tree().change_scene(GotoRoom)
			SaveGame.game_data.RoomNum += 1
		else: 
			_get_next_room()
	elif (SaveGame.game_data.RoomNum == 99):
		var _error = get_tree().change_scene("res://scenes/rooms/100/room100.tscn")
	elif (SaveGame.game_data.RoomNum == 149):
		var _error = get_tree().change_scene("res://scenes/rooms/200/room50.tscn")
	elif (SaveGame.game_data.RoomNum == 174):
		var _error = get_tree().change_scene("res://scenes/rooms/200/room75.tscn")
	elif (SaveGame.game_data.RoomNum >= 199):
		var _error = get_tree().change_scene("res://scenes/EndScreen.tscn")
	elif (SaveGame.game_data.RoomNum > 99):
#		var _error = get_tree().change_scene("res://scenes/EndScreen.tscn")
		# Uncomment stuff below when it's fully working
		# also add in code so you always arrive at room 201 after room 100

		RoomRNG = randi() % 15 + 1
		GotoRoom = str("res://scenes/rooms/200/room" + str(RoomRNG) + ".tscn")
		if GotoRoom != LastRoom:
			var _error = get_tree().change_scene(GotoRoom)
			SaveGame.game_data.RoomNum += 1
		else: 
			_get_next_room()

