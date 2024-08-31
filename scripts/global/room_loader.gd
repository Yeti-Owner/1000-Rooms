extends Node

const floor1_list:Array = ["res://rooms/100/room_1.tscn", "res://rooms/100/room_2.tscn", "res://rooms/100/room_3.tscn"]

# This script is to load the next room (duh)

func _ready():
	randomize()

func _find_next(current_num:int):
	var next_room:String
	
	# if statements to restrict to <100, <200, etc
	# switch/match cases to check for "special rooms" ie room 50
	# check if same as EventBus.current_room, if same call itself
	# if not, return new room path
	
	next_room = floor1_list.pick_random()
	
	if next_room == EventBus.current_room:
		_find_next(current_num)
	else:
		return next_room
