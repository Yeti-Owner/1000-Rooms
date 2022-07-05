extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
export(String) var _room 

func _ready():
	SaveGame.game_data.CurrentRoom = _room
	fader._fade_in()
	Narrator.messages = [""]

#func _process(delta):
#	pass
