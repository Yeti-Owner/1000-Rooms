extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
export(String) var _room 

func _ready():
	SaveGame.game_data.CurrentRoom = _room
	SaveGame.game_data.RoomNum = 176
	SaveGame.game_data.LastCheckPoint = _room
	SaveGame.game_data.PlayerHP += 5
	SaveGame._save()
	fader._fade_in()
	Narrator.messages = ["Very well done!","You're almost done with this section."]
