extends Node

var LastRoom:String
var GotoRoom:String
var RoomRNG:int
var RNG100 := [1,1,2,2,3,3,4,4,5,5,6,6,7,8,9,9,10,10,11,11,12,12,13,14,14,15,15,16,16,17,17,18,18,19,19,20,20]
var RNG200 := [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,9,10,10,11,11,12,12,13,14,14,15,16,16,17,17,18,18,19,19,20,20]
var RNG300 := [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,9,9,10,10,11,11,12,13,14,14,15,16,16,17,17,18,18,19,19,20,20]

func _ready():
	randomize()

func _get_next_room():
	if SaveGame.game_data.RoomNum <= 100:
		_100_rooms()
	elif SaveGame.game_data.RoomNum <= 199:
		_200_rooms()
	elif SaveGame.game_data.RoomNum <= 298:
		_300_rooms()
	elif SaveGame.game_data.RoomNum > 298:
		SaveGame.game_data.RoomNum += 1
		SceneManager._init_HUD("endscreen")

func _100_rooms():
	LastRoom = SaveGame.game_data.CurrentRoom
	match SaveGame.game_data.RoomNum:
		17:
			SceneManager._change_scene("res://scenes/rooms/100/room1.tscn")
			SaveGame.game_data.RoomNum += 1
		29:
			SceneManager._change_scene("res://scenes/rooms/100/room10.tscn")
			SaveGame.game_data.RoomNum += 1
		48:
			SceneManager._change_scene("res://scenes/rooms/100/room12.tscn")
			SaveGame.game_data.RoomNum += 1
		49:
			SceneManager._change_scene("res://scenes/rooms/100/room50.tscn")
			SaveGame.game_data.RoomNum += 1
		57:
			SceneManager._change_scene("res://scenes/rooms/100/room14.tscn")
			SaveGame.game_data.RoomNum += 1
		74:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/100/room75.tscn")
		99:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/100/room100.tscn")
		100: 
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/200/IntroRoom.tscn")
		_:
			RoomRNG = RNG100[randi() % RNG100.size()]
			GotoRoom = str("res://scenes/rooms/100/room" + str(RoomRNG) + ".tscn")
			if GotoRoom != LastRoom:
				SceneManager._change_scene(GotoRoom)
				SaveGame.game_data.RoomNum += 1
			else: 
				_100_rooms()

func _200_rooms():
	LastRoom = SaveGame.game_data.CurrentRoom
	match SaveGame.game_data.RoomNum:
		102:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/200/room8.tscn")
		103:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/200/room14.tscn")
		123:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/200/room13.tscn")
		149:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/200/room50.tscn")
		174:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/200/room75.tscn")
		175:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/200/room76.tscn")
		199:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/200/room200.tscn")
		_:
			RoomRNG = RNG200[randi() % RNG200.size()]
			GotoRoom = str("res://scenes/rooms/200/room" + str(RoomRNG) + ".tscn")
			if GotoRoom != LastRoom:
				SceneManager._change_scene(GotoRoom)
				SaveGame.game_data.RoomNum += 1
			else: 
				_200_rooms()

func _300_rooms():
	LastRoom = SaveGame.game_data.CurrentRoom
	match SaveGame.game_data.RoomNum:
		249:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/300/room50.tscn")
		274:
			SaveGame.game_data.RoomNum += 1
			SceneManager._change_scene("res://scenes/rooms/300/room75.tscn")
		_:
			RoomRNG = RNG100[randi() % RNG100.size()]
			GotoRoom = str("res://scenes/rooms/300/room" + str(RoomRNG) + ".tscn")
			if GotoRoom != LastRoom:
				SceneManager._change_scene(GotoRoom)
				SaveGame.game_data.RoomNum += 1
			else:
				_300_rooms()
