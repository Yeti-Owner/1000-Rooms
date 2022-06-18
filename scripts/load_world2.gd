extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
export(String) var _room 
export(Vector3) var MonsterLocation

func _ready():
	SaveGame.game_data.CurrentRoom = _room
	fader._fade_in()
	_check_room()

func _check_room():
	pass
#	if _room == "res://scenes/world.tscn":
#		Narrator.messages = ["Welcome to my dungeon", "have fun"]
#	elif _room == "res://scenes/rooms/100/room13.tscn" && SaveGame.FirstTimeRoom13:
#		Narrator.messages = ["This room is an interesting one", "I'll give you a hint though", "I'm not a fan of tedious puzzles.", "I'd rather just hide the solution in plain sight"]
#		SaveGame.FirstTimeRoom13 = 0
