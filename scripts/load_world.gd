extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
export(String) var _room 

func _ready():
	Settingsholder.CurrentRoom = _room
	fader._fade_in()
	_check_room()

func _check_room():
	if _room == "res://scenes/world.tscn":
		Narrator.messages = ["Welcome to my dungeon", "have fun"]
