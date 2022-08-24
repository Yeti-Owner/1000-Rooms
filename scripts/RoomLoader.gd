extends Node

var LastRoom
var GotoRoom
var RoomRNG

func _ready():
	randomize()

# There is 100% a better way to do this but I am too mentally handicapped
# to figure it out

func _get_next_room():
	LastRoom = SaveGame.game_data.CurrentRoom
	match SaveGame.game_data.RoomNum:
		17:
			var _error = get_tree().change_scene("res://scenes/rooms/100/room1.tscn")
			SaveGame.game_data.RoomNum += 1
		29:
			var _error = get_tree().change_scene("res://scenes/rooms/100/room10.tscn")
			SaveGame.game_data.RoomNum += 1
		48:
			var _error = get_tree().change_scene("res://scenes/rooms/100/room12.tscn")
			SaveGame.game_data.RoomNum += 1
		49:
			var _error = get_tree().change_scene("res://scenes/rooms/100/room50.tscn")
			SaveGame.game_data.RoomNum += 1
		74:
			SaveGame.game_data.RoomNum += 1
			var _error = get_tree().change_scene("res://scenes/rooms/100/room75.tscn")
		99:
			SaveGame.game_data.RoomNum += 1
			var _error = get_tree().change_scene("res://scenes/rooms/100/room100.tscn")
		100: 
			SaveGame.game_data.RoomNum += 1
			var _error = get_tree().change_scene("res://scenes/rooms/200/IntroRoom.tscn")
		102:
			SaveGame.game_data.RoomNum += 1
			var _error = get_tree().change_scene("res://scenes/rooms/200/room8.tscn")
		103:
			SaveGame.game_data.RoomNum += 1
			var _error = get_tree().change_scene("res://scenes/rooms/200/room14.tscn")
		149:
			SaveGame.game_data.RoomNum += 1
			var _error = get_tree().change_scene("res://scenes/rooms/200/room50.tscn")
		174:
			SaveGame.game_data.RoomNum += 1
			var _error = get_tree().change_scene("res://scenes/rooms/200/room75.tscn")
		175:
			SaveGame.game_data.RoomNum += 1
			var _error = get_tree().change_scene("res://scenes/rooms/200/room76.tscn")
		199:
			var _error = get_tree().change_scene("res://scenes/EndScreen.tscn")
		_:
			if SaveGame.game_data.RoomNum < 99:
				RoomRNG = randi() % 15 + 1
				GotoRoom = str("res://scenes/rooms/100/room" + str(RoomRNG) + ".tscn")
				if GotoRoom != LastRoom:
					var _error = get_tree().change_scene(GotoRoom)
					SaveGame.game_data.RoomNum += 1
				else: 
					_get_next_room()
			elif (SaveGame.game_data.RoomNum >= 199):
				var _error = get_tree().change_scene("res://scenes/EndScreen.tscn")
			elif (SaveGame.game_data.RoomNum > 99):
				RoomRNG = randi() % 15 + 1
				GotoRoom = str("res://scenes/rooms/200/room" + str(RoomRNG) + ".tscn")
				if GotoRoom != LastRoom:
					var _error = get_tree().change_scene(GotoRoom)
					SaveGame.game_data.RoomNum += 1
				else: 
					_get_next_room()
