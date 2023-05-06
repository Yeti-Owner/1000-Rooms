extends Spatial

onready var Narrator := $Narrator
onready var _room := self.filename

func _ready():
	$ReflectionProbe.intensity = 0.01
	SaveGame.game_data.CurrentRoom = _room
	SaveGame.game_data.RoomNum = 176
	SaveGame.game_data.LastCheckPoint = _room
	SaveGame._save()
	Narrator.messages = ["Very well done!","You're almost done with this floor."]
