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
	if _room == "res://scenes/rooms/200/room10.tscn" && SaveGame.FirstTimeRoom210:
		Narrator.messages = ["I don't remember making this room", "This may be bad","But no fear, all rooms are created to be possible."]
		SaveGame.FirstTimeRoom210 = 0
	elif _room == "res://scenes/rooms/200/room8.tscn" && SaveGame.FirstTimeParkour:
		Narrator.messages = ["Hope you're ready for some parkour"]
		SaveGame.FirstTimeParkour = 0
	elif _room == "res://scenes/rooms/200/room11.tscn" && SaveGame.FirstTimeRoom211:
		Narrator.messages = ["I'm terribly sorry but I do enjoy making large rooms"]
		SaveGame.FirstTimeRoom211 = 0
	elif _room == "res://scenes/rooms/200/room12.tscn" && (SaveGame.FirstTimeRoom212 == 1):
		Narrator.messages = ["I'm quite sorry I don't remember leaving all this junk around.","Do the opposite of what the signs say,","I don't even remember what is written"]
		SaveGame.FirstTimeRoom212 = 2
	elif _room == "res://scenes/rooms/200/room12.tscn" && (SaveGame.FirstTimeRoom212 == 2):
		Narrator.messages = ["Again I'm very sorry","Most of the signs should be cleaned up now"]
		get_node("root/world/Fader/Plaque2").queue_free()
		get_node("root/world/Fader/Plaque4").queue_free()
		get_node("root/world/Fader/Plaque6").queue_free()
		SaveGame.FirstTimeRoom212 = 0
	elif _room == "res://scenes/rooms/200/room13.tscn" && SaveGame.FirstTimeRoom213:
		Narrator.messages = ["Oh","...","this room isn't very fun"]
		SaveGame.FirstTimeRoom213 = 0
	elif _room == "res://scenes/rooms/200/room14.tscn" && SaveGame.FirstTimeRoom214:
		Narrator.messages = ["This may require some trial and error but I believe in you!"]
		SaveGame.FirstTimeRoom214 = 0
	elif _room == "res://scenes/rooms/200/room15.tscn" && SaveGame.FirstTimeRoom215:
		Narrator.messages = ["Before you begin...","I'd like you to know I'm sorry"]
		SaveGame.FirstTimeRoom215 = 0
