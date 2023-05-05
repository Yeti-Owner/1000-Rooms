extends Spatial

export(Environment) var EnvironmentUsed 
onready var Narrator := $Narrator
onready var player := $RoomItems/Player
onready var _room := self.filename

var RuneStage:int = 0

func _ready():
	randomize()
	$ReflectionProbe.intensity = 0.01
	SceneManager.GameScene.world.environment = EnvironmentUsed
	SaveGame.game_data.CurrentRoom = _room
	if SaveGame.game_data.CurrentPos == Vector3(-4.1, -5.35, -41.9):
		Narrator.messages = ["You weren't careful"]
		player.global_transform.origin = Vector3(-4.1, -5.35, -41.9)
		$RoomItems/FairyHolder.queue_free()
	else:
		Narrator.messages = ["Before you progress let me explain some things.","Just up ahead is the Fairy nesting area.","You obviously need to move carefully, they are bouncing around sporadically and if you are found it could be disastrous.","in order to progress you must find 5 Runes.","The first rune is just ahead on the wall."]

func _rune_found():
	RuneStage += 1
	match RuneStage:
		2:
			Narrator.messages = ["Well done, only 3 more!"]
			Narrator.start_dialogue()
		3:
			Narrator.messages = ["You're getting there, 2 more!"]
			Narrator.start_dialogue()
		4:
			Narrator.messages = ["So close, only 1 more to go."]
			Narrator.start_dialogue()
		5:
			Narrator.messages = ["Now quickly find the exit in the center of the room."]
			Narrator.start_dialogue()
			$RoomItems/MovingPillar._move()
			$RoomItems/Rune5.queue_free()

func _on_Area_area_entered(area):
	if area.name == "PlayerArea":
		Narrator.messages = ["Up ahead may be the hardest part.","Do be careful please."]
		Narrator.start_dialogue()

func _on_Sensor_PlayerDetected():
	$RoomItems/MovingPillar.Pos = $RoomItems/MovingPillar.global_transform.origin
	$RoomItems/MovingPillar.NewPos = Vector3(0, 0, 0)
	$RoomItems/MovingPillar._move()
	$RoomItems/FairyHolder.queue_free()
