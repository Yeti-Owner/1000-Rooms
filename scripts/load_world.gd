extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
onready var Objs = $Objs
export(String) var _room 
#export(Vector3) var MonsterLocation
var RNG

func _ready():
	randomize()
	_add_objs()
	SaveGame.game_data.CurrentRoom = _room
	fader._fade_in()
	_check_room()

func _check_room():
	if _room == "res://scenes/world.tscn":
		Narrator.messages = ["Welcome to my dungeon", "it's a bit bigger on the inside","I wonder how far you'll make"]
	elif _room == "res://scenes/rooms/100/room13.tscn" && SaveGame.FirstTimeRoom13:
		Narrator.messages = ["This room is an interesting one", "I'll give you a hint though", "I'm not a fan of tedious puzzles.", "I'd rather just hide the solution in plain sight"]
		SaveGame.FirstTimeRoom13 = 0

func _add_objs():
	for _i in Objs.get_children():
		RNG = randi() % 5
		if RNG == 0:
			_i.visible = true
		else:
			_i.queue_free()
