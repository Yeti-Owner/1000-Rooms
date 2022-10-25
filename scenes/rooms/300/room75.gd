extends Spatial

export(Environment) var EnvironmentUsed

onready var Narrator := $Narrator
onready var _room := self.filename
onready var Player := $RoomItems/Player

func _ready():
	randomize()
	SceneManager.GameScene.world.environment = EnvironmentUsed
	SaveGame.game_data.CurrentRoom = _room
	SaveGame._update_presence()
	if SaveGame.game_data.CurrentPos == Vector3(-1.9,1,-54):
		Player.global_transform.origin = Vector3(-1.9,1,-54)
	else:
		pass

func _on_FakePipe_PipeEntered():
	Player.global_transform.origin = Vector3(-2,0.9,-42)
