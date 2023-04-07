extends Node

const save_data := "user://save_game.dat"

# Unsaved vars
var isChased := 0
var ChasedBy := 0 # 0 = ghost, 1 = [PLACEHOLDER]
var LastSavedRoomNum:int = 0
var DeathReason:String

signal EnemyPassive

# Saved Vars
var game_data := {
	"RoomNum" : 0,
	"MaxRoomNum" : 0,
	"PlayerHP" : 100,
	"JumpScareAmt" : 0,
	"CurrentRoom" : "res://scenes/world.tscn",
	"CurrentPos" : Vector3(1,1,1),
	"LastCheckPoint" : "res://scenes/world.tscn",
	"LastSavedRoom" : 0,
	"EnabledShield" : 0,
	"Reputation" : 0,
	"Deaths" : 0,
	"Intro" : 0,
	"StepUsed" : 0,
	"FirstTimeRoom13" : 1,
	"FirstTimeRoom210" : 1,
	"FirstTimeRoom211" : 1,
	"FirstTimeRoom212" : 1,
	"FirstTimeRoom213" : 1,
	"FirstTimeRoom214" : 1,
	"FirstTimeRoom215" : 1,
	"FirstTimeParkour" : 1,
	"FirstTimeAcid" : 1,
	"FirstTimeLights" : 1,
	"FirstTimeRoom305" : 1,
	"FirstTimeRoom306" : 1,
	"FirstTimeRoom309" : 1,
	"FirstTimeConfusing300" : 1,
	"FirstTimeConfusing312" : 1
}

func _ready():
	if not FileAccess.file_exists(save_data):
		_save()
	else:
		_load()

func _save():
	var file := FileAccess.open(save_data, FileAccess.WRITE)
	file.store_var(game_data)

func _load():
	# Open save file and read values
	var file := FileAccess.open(save_data, FileAccess.READ)
	game_data = file.get_var()
	
	_check_contents()

func _check_contents():
	game_data.RoomNum = game_data.get("RoomNum", 0)
	game_data.MaxRoomNum = game_data.get("MaxRoomNum", 0)
	game_data.PlayerHP = game_data.get("PlayerHP", 100)
	game_data.JumpScareAmt = game_data.get("JumpScareAmt", 0)
	game_data.CurrentRoom = game_data.get("CurrentRoom", "res://scenes/world.tscn")
	game_data.CurrentPos = game_data.get("CurrentPos", Vector3(1,1,1))
	game_data.LastCheckPoint = game_data.get("LastCheckPoint", "res://scenes/world.tscn")
	game_data.LastSavedRoom = game_data.get("LastSavedRoom", 0)
	game_data.EnabledShield = game_data.get("EnabledShield", 0)
	game_data.Reputation = game_data.get("Reputation", 0)
	game_data.Deaths = game_data.get("Deaths", 0)
	game_data.Intro = game_data.get("Intro", 0)
	game_data.StepUsed = game_data.get("StepUsed", 0)
	game_data.FirstTimeRoom13 = game_data.get("FirstTimeRoom13", 1)
	game_data.FirstTimeRoom210 = game_data.get("FirstTimeRoom210", 1)
	game_data.FirstTimeRoom211 = game_data.get("FirstTimeRoom211", 1)
	game_data.FirstTimeRoom212 = game_data.get("FirstTimeRoom212", 1)
	game_data.FirstTimeRoom213 = game_data.get("FirstTimeRoom213", 1)
	game_data.FirstTimeRoom214 = game_data.get("FirstTimeRoom214", 1)
	game_data.FirstTimeRoom215 = game_data.get("FirstTimeRoom215", 1)
	game_data.FirstTimeParkour = game_data.get("FirstTimeParkour", 1)
	game_data.FirstTimeAcid = game_data.get("FirstTimeAcid", 1)
	game_data.FirstTimeLights = game_data.get("FirstTimeLights", 1)
	game_data.FirstTimeRoom305 = game_data.get("FirstTimeRoom305", 1)
	game_data.FirstTimeRoom306 = game_data.get("FirstTimeRoom306", 1)
	game_data.FirstTimeRoom309 = game_data.get("FirstTimeRoom309", 1)
	game_data.FirstTimeConfusing300 = game_data.get("FirstTimeConfusing300", 1)
	game_data.FirstTimeConfusing312 = game_data.get("FirstTimeConfusing312", 1)

func _clear_save():
	game_data = {
		"RoomNum" : 0,
		"MaxRoomNum" : 0,
		"PlayerHP" : 100,
		"JumpScareAmt" : 0,
		"CurrentRoom" : "res://scenes/world.tscn",
		"CurrentPos" : Vector3(1,1,1),
		"LastCheckPoint" : "res://scenes/world.tscn",
		"LastSavedRoom" : 0,
		"EnabledShield" : 0,
		"Reputation" : 0,
		"Deaths" : 0,
		"Intro" : 1,
		"StepUsed" : 0,
		"FirstTimeRoom13" : 1,
		"FirstTimeRoom210" : 1,
		"FirstTimeRoom211" : 1,
		"FirstTimeRoom212" : 1,
		"FirstTimeRoom213" : 1,
		"FirstTimeRoom214" : 1,
		"FirstTimeRoom215" : 1,
		"FirstTimeParkour" : 1,
		"FirstTimeAcid" : 1,
		"FirstTimeLights" : 1,
		"FirstTimeRoom305" : 1,
		"FirstTimeRoom306" : 1,
		"FirstTimeRoom309" : 1,
		"FirstTimeConfusing300" : 1,
		"FirstTimeConfusing312" : 1
	}
	_save()

func _update_presence():
	pass
#	print("updating presence")
#	var activity = Discord.Activity.new()
#	activity.set_type(Discord.ActivityType.Playing)
#	activity.set_state("In Room: " + str(SaveGame.game_data.RoomNum))
#	activity.set_details("Running for their life")
#
#	var assets = activity.get_assets()
#	assets.set_large_image("title")
#	assets.set_large_text("1000-Rooms")
#	assets.set_small_image("blank")
#	assets.set_small_text("")

#	var result = await Discord.activity_manager.update_activity(activity).result.result
#	if result != Discord.Result.Ok:
#		push_error(result)

