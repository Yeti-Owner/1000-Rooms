extends Node

const save_path = "user://achievements.dat"

var game_data := {
	"FormagDrung" : 0,
	"Badenov" : 0,
	"NotoLotta" : 0,
	"Shai" : 0,
	"Ufrz" : 0,
	"Asshole" : 0,
	"Wyoming" : 0,
	"Brawlhalla" : 0,
	"Hell" : 0,
	"IQTest" : 0
}

signal NewAchievement

func _ready():
	if not FileAccess.file_exists(save_path):
		_save()
	else:
		_load()

func _check_contents():
	game_data.FormagDrung = game_data.get("FormagDrung", 0)
	game_data.Badenov = game_data.get("Badenov", 0)
	game_data.NotoLotta = game_data.get("NotoLotta", 0)
	game_data.Shai = game_data.get("Shai", 0)
	game_data.Ufrz = game_data.get("Ufrz", 0)
	game_data.Asshole = game_data.get("Asshole", 0)
	game_data.Wyoming = game_data.get("Wyoming", 0)
	game_data.Brawlhalla = game_data.get("Brawlhalla", 0)
	game_data.Hell = game_data.get("Hell", 0)
	game_data.IQTest = game_data.get("IQTest", 0)

func _save():
	var file := FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(game_data)

func _load():
	
	var file := FileAccess.open(save_path, FileAccess.READ)
	game_data = file.get_var()
	
	_check_contents()
