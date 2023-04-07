extends Node3D

@export var EnvironmentUsed: Environment
@onready var Narrator := $Narrator
@onready var _room := self.filename
@onready var Player := $RoomItems/Player

func _ready():
	randomize()
	SceneManager.GameScene.world.environment = EnvironmentUsed
	SaveGame.game_data.CurrentRoom = _room
	
	SaveGame._update_presence()
	if SaveGame.game_data.CurrentPos == Vector3(-1.9,1,-54):
		Player.global_transform.origin = Vector3(-1.9,1,-54)
		Narrator.messages = ["Nice seeing you again."]
	else:
		Narrator.messages = ["You better find the exit before they find you."]
# warning-ignore:return_value_discarded
		$RoomItems/FakePipe/StaticBody3D.connect("PipeEntered",Callable(self,"_on_FakePipe_PipeEntered"))

func _on_FakePipe_PipeEntered():
	Player.global_transform.origin = Vector3(-2,0.9,-42)
	Player.scale = Vector3(0.6,0.6,0.6)
