extends Node3D

@export var EnvironmentUsed: Environment

@onready var Narrator := $Narrator
@onready var _room := self.filename
@onready var Player := $RoomItems/Player
@onready var TimeLabel := $RoomItems/StaticBody3D/TimeLeft
@onready var SecondTimer := $RoomItems/StaticBody3D/SecondTimer
var stage:int = 0
var Seconds:int = 29

func _ready():
	randomize()
	
	SceneManager.GameScene.world.environment = EnvironmentUsed
	SaveGame.game_data.CurrentRoom = _room
	SaveGame._update_presence()
	if SaveGame.game_data.CurrentPos == Vector3(30.7, 1, -10.3):
		Narrator.messages = ["You come here often?","...","I'm sorry."]
		Player.global_transform.origin = Vector3(30.7, 1, -10.3)
		$LightHandler.queue_free()
	else:
# warning-ignore:return_value_discarded
		Narrator.connect("DialogueFinished",Callable(self,"_dialogue_finished"))
		Narrator.messages = ["Be prepared, there is a time trial ahead.","You must grab all the orbs before the time runs out.","Ready in.."]

func _on_Sensor_PlayerDetected():
	$GridMap3/walls.global_transform.origin = Vector3(-2, 0, 0)

func _dialogue_finished():
	$CountDown.start()

func _on_Timer_timeout():
	match stage:
		0:
			Narrator.messages = ["3"]
			Narrator.start_dialogue()
			stage = 1
		1:
			Narrator.messages = ["2"]
			Narrator.start_dialogue()
			stage = 2
		2:
			Narrator.messages = ["1"]
			Narrator.start_dialogue()
			stage = 3
		3:
			Narrator.messages = ["GO"]
			$GridMap3/walls.global_transform.origin = Vector3(0, 10, 0)
			Narrator.start_dialogue()
			stage = 4
			$DeathTimer.start()
			SecondTimer.start()

func _on_DeathTimer_timeout():
	SaveGame.game_data.PlayerHP = 1
	SceneManager._reload_scene()

func _lights_complete():
	$DeathTimer.stop()
	$GridMap3/walls2.queue_free()
	SecondTimer.stop()

func _on_SecondTimer_timeout():
	Seconds -= 1
	if Seconds < 10:
		TimeLabel.text = str("0:0" + str(Seconds))
	else:
		TimeLabel.text = str("0:" + str(Seconds))
	SecondTimer.start()
