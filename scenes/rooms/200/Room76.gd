extends Spatial

onready var Narrator = $Narrator
onready var _room = self.filename
export(Environment) var EnvironmentUsed 

func _ready():
	SceneManager.GameScene.world.environment = EnvironmentUsed
	SaveGame.game_data.CurrentRoom = _room
	SaveGame.game_data.RoomNum = 176
	SaveGame.game_data.LastCheckPoint = _room
	SaveGame.game_data.PlayerHP += 5
	SaveGame._save()
	Narrator.messages = ["Very well done!","You're almost done with this section."]
