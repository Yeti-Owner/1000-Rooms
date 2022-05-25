extends Spatial

onready var fader = $Fader
export var _room = ""

func _ready():
	Settingsholder.CurrentRoom = _room
	fader._fade_in()
