extends Node

var file = File.new()
var save_game = "user://save_game.dat"


var RoomNum = 0
var ShowFps = 0
var MouseSensitivity = 18
var PlayerFOV = 70
var FrameRate = 60
var BloomSet = 0
var VsyncEnabled = 0

var CurrentRoom = ''

# Check saved data
func _ready():
	# If save file doesnt exist put in default values
	if not file.file_exists(save_game):
		_save()
	
	# Open save file and read values
	file.open(save_game, File.READ)
	RoomNum = file.get_8()
	ShowFps = file.get_8()
	MouseSensitivity = file.get_8()
	PlayerFOV = file.get_8()
	FrameRate = file.get_8()
	BloomSet = file.get_8()
	VsyncEnabled = file.get_8()
	file.close()

func _save():
	file.open(save_game, File.WRITE)
	file.store_buffer([RoomNum, ShowFps, MouseSensitivity, PlayerFOV, FrameRate, BloomSet, VsyncEnabled])
	file.close()
