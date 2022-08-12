extends Node

var file = File.new()
var save_data = "user://save_game.dat"

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
	"CurrentPos" : Vector3(1,1,1),
	"LastCheckPoint" : "res://scenes/world.tscn",
	"LastSavedRoom" : 0,
	"EnabledShield" : 0,
	"Reputation" : 0,
	"FirstTimeRoom13" : 1,
	"FirstTimeRoom210" : 1,
	"FirstTimeRoom211" : 1,
	"FirstTimeRoom212" : 1,
	"FirstTimeRoom213" : 1,
	"FirstTimeRoom214" : 1,
	"FirstTimeRoom215" : 1,
	"FirstTimeParkour" : 1
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

func _update_presence():
	var activity = Discord.Activity.new()
	activity.set_type(Discord.ActivityType.Playing)
	activity.set_state("In Room: " + str(SaveGame.game_data.RoomNum))
	activity.set_details("Running for their life")

	var assets = activity.get_assets()
	assets.set_large_image("title")
	assets.set_large_text("1000-Rooms")
	assets.set_small_image("blank")
	assets.set_small_text("")

	var result = yield(Discord.activity_manager.update_activity(activity), "result").result
	if result != Discord.Result.Ok:
		push_error(result)
