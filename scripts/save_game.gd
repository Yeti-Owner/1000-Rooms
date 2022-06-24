extends Node

var file = File.new()
var save_data = "user://save_game.dat"

# Onetime Vars
# first # is which hundred it is, ie 1 = 100
var FirstTimeRoom13 = 1
var FirstTimeRoom210 = 1
var FirstTimeRoom211 = 1
var FirstTimeRoom212 = 1
var FirstTimeRoom213 = 1
var FirstTimeRoom214 = 1
var FirstTimeRoom215 = 1
var FirstTimeParkour = 1

# Unsaved vars
var isChased = 0
var ChasedBy = 0 # 0 = ghost, 1 = [PLACEHOLDER]
var LastSavedRoomNum = 0

# Saved Vars
var game_data = {
	"RoomNum" : 0,
	"PlayerHP" : 100,
	"JumpScareAmt" : 0,
	"CurrentRoom" : "res://scenes/world.tscn",
	"CurrentPos" : 1,
	"LastCheckPoint" : "res://scenes/world.tscn",
	"LastSavedRoom" : 0
}

# Check saved data
func _ready():
	_load()

func _load():
	# If save file doesnt exist put in default values
	if not file.file_exists(save_data):
		_save()
		
	# Open save file and read values
	file.open(save_data, File.READ)
	game_data = file.get_var()
	file.close()

func _save():
	file.open(save_data, File.WRITE)
	file.store_var(game_data)
	file.close()
