extends Spatial

export(Environment) var EnvironmentUsed
onready var Narrator := $Narrator
onready var _room := self.filename

func _ready():
	SceneManager.GameScene.world.environment = EnvironmentUsed
	
	SaveGame.game_data.CurrentRoom = _room
	SaveGame.game_data.RoomNum = 101
	SaveGame.game_data.LastCheckPoint = _room
	
	SaveGame._save()
	Narrator.messages = ["You've avoided it for now, but you haven't escaped it.","The next 100 rooms are hard enough on their own but I fear the Fairy will keep chasing you.","Remember, Fairies have horrible vision","it will just randomly search for you so try to watch it's search pattern and avoid it"]
