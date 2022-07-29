extends Node

var file = File.new()
var save_data = "user://achievements.dat"

var game_data = {
	"FormagDrung" : 0,
	"Badenov" : 0,
	"NotoLotta" : 0,
	"Blackout" : 0,
	"Shai" : 0,
	"Hito" : 0,
	"Ufrz" : 0,
	"Asshole" : 0,
	"Wyoming" : 0,
	"Brawlhalla" : 0
}

signal NewAchievement

func _ready():
	_load()

func _save():
	file.open(save_data, File.WRITE)
	file.store_var(game_data)
	file.close()

func _load():
	# If save file doesnt exist put in default values
	if not file.file_exists(save_data):
		_save()
		
	# Open save file and read values
	file.open(save_data, File.READ)
	game_data = file.get_var()
	file.close()
