extends Spatial

onready var fader = $Fader
export(String) var _room 

func _ready():
	Settingsholder.CurrentRoom = _room
	fader._fade_in()
