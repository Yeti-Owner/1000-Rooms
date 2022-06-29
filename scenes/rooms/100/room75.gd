extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
onready var Objs = $Objs
export(String) var _room 
var RNG

func _ready():
	Narrator.messages = ["I'm afraid I can't help you in this room.","All I can tell you is to be very careful.","You will only get 1 chance to choose the correct hallway."]
	SaveGame.game_data.CurrentRoom = _room
	fader._fade_in()

