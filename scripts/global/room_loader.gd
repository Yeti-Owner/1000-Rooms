extends Node

# This script is to load the next room (duh)

func _find_next(current_num:int):
	# if statements to restrict to <100, <200, etc
	# switch/match cases to check for "special rooms" ie room 50
	# check if same as EventBus.current_room, if same call itself
	# if not, return new room path
	return "res://rooms/100/room_2.tscn"
	pass
