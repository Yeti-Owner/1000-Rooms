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

# warning-ignore:unused_signal
signal NewAchievement

func _ready():
	_load()

func _check_contents():
	game_data.FormagDrung = game_data.get("FormagDrung", 0)
	game_data.Badenov = game_data.get("Badenov", 0)
	game_data.NotoLotta = game_data.get("NotoLotta", 0)
	game_data.Blackout = game_data.get("Blackout", 0)
	game_data.Shai = game_data.get("Shai", 0)
	game_data.Hito = game_data.get("Hito", 0)
	game_data.Ufrz = game_data.get("Ufrz", 0)
	game_data.Asshole = game_data.get("Asshole", 0)
	game_data.Wyoming = game_data.get("Wyoming", 0)
	game_data.Brawlhalla = game_data.get("Brawlhalla", 0)

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
	
	_check_contents()
