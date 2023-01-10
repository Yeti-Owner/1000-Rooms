extends Spatial

onready var Narrator := $Narrator
onready var MonsterHandler := $EnemyPath/PathFollow
onready var _room := self.filename
export(bool) var AllowChase = true
export(Environment) var EnvironmentUsed 
var FairyEnemy := preload("res://scenes/enemies/FairyEnemy.tscn")
var ChaseList := ["HURRY!","IT'S HERE!","RUN!","HIDE!"]
var ReRunSpawn:bool = true

func _ready():
	$ReflectionProbe.intensity = 0.01
# warning-ignore:return_value_discarded
	$Narrator.connect("DialogueFinished", self, "_dialogue_finished")
	randomize()
	SceneManager.GameScene.world.environment = EnvironmentUsed
	SaveGame.game_data.CurrentRoom = _room
	_check_room()
	_add_objs()
	SaveGame._update_presence()

func _check_room():
	if _room == "res://scenes/rooms/200/room10.tscn" && SaveGame.game_data.FirstTimeRoom210:
		AllowChase = false
		Narrator.messages = ["I don't remember making this room", "This may be bad","But no fear, all rooms are created to be possible."]
		SaveGame.game_data.FirstTimeRoom210 = 0
	elif _room == "res://scenes/rooms/200/room8.tscn" && SaveGame.game_data.FirstTimeParkour:
		AllowChase = false
		Narrator.messages = ["Hope you're ready for some parkour"]
		SaveGame.game_data.FirstTimeParkour = 0
	elif _room == "res://scenes/rooms/200/room11.tscn" && SaveGame.game_data.FirstTimeRoom211:
		AllowChase = false
		Narrator.messages = ["I'm terribly sorry but I do enjoy making large rooms"]
		SaveGame.game_data.FirstTimeRoom211 = 0
	elif _room == "res://scenes/rooms/200/room12.tscn" && (SaveGame.game_data.FirstTimeRoom212 == 1):
		AllowChase = false
		Narrator.messages = ["I'm quite sorry I don't remember leaving all this junk around.","Do the opposite of what the signs say,","I don't even remember what is written"]
		SaveGame.game_data.FirstTimeRoom212 = 2
	elif _room == "res://scenes/rooms/200/room12.tscn" && (SaveGame.game_data.FirstTimeRoom212 == 2):
		AllowChase = false
		Narrator.messages = ["Again I'm very sorry","Most of the signs should be cleaned up now"]
		get_node("RoomItems/Plaque2").queue_free()
		get_node("RoomItems/Plaque4").queue_free()
		get_node("RoomItems/Plaque6").queue_free()
		SaveGame.FirstTimeRoom212 = 3
	elif _room == "res://scenes/rooms/200/room12.tscn" && (SaveGame.game_data.FirstTimeRoom212 == 3):
		AllowChase = false
		get_node("RoomItems/Plaque2").queue_free()
		get_node("RoomItems/Plaque4").queue_free()
		get_node("RoomItems/Plaque6").queue_free()
	elif _room == "res://scenes/rooms/200/room13.tscn" && SaveGame.game_data.FirstTimeRoom213:
		Narrator.messages = ["Oh","...","this room isn't very fun"]
		SaveGame.game_data.FirstTimeRoom213 = 0
	elif _room == "res://scenes/rooms/200/room14.tscn" && SaveGame.game_data.FirstTimeRoom214:
		AllowChase = false
		Narrator.messages = ["This may require some trial and error but I believe in you!"]
		SaveGame.game_data.FirstTimeRoom214 = 0
	elif _room == "res://scenes/rooms/200/room15.tscn" && SaveGame.game_data.FirstTimeRoom215:
		Narrator.messages = ["Before you begin...","I'd like you to know I'm sorry"]
		SaveGame.game_data.FirstTimeRoom215 = 0
	elif SaveGame.game_data.RoomNum == 103:
		AllowChase = false
	elif _room == "res://scenes/rooms/200/room8.tscn" and SaveGame.game_data.RoomNum != 103:
		$Table3.queue_free()
	elif SaveGame.game_data.RoomNum == 104:
		AllowChase = false
	elif _room == "res://scenes/rooms/200/room14.tscn" and SaveGame.game_data.RoomNum != 104:
		$Table2.queue_free()
	elif _room == "res://scenes/rooms/200/room13.tscn" and SaveGame.game_data.RoomNum == 122:
		$Table1.visible = true
	elif _room == "res://scenes/rooms/200/room13.tscn" and SaveGame.game_data.RoomNum != 122:
		$Table1.queue_free()

func _dialogue_finished():
	if ReRunSpawn == true:
		_chasing()

func _add_objs():
	for _i in $Objs.get_children():
		var RNG := randi() % 3
		if RNG == 0:
			_i.visible = true
		else:
			_i.queue_free()

func _chasing():
	if AllowChase:
		var RNG := randi() % 5
		if (RNG == 0) or SaveGame.isChased > 0:
			Narrator.messages = [ChaseList[randi() % 4]]
			Narrator.start_dialogue()
			$SpawnTimer.start()
			ReRunSpawn = false
			if SaveGame.isChased == 0:
				SaveGame.isChased = 3
			else:
				SaveGame.isChased -= 1

func _on_SpawnTimer_timeout():
	$RoomItems/wall.queue_free()
	var FairyEnemy2 = FairyEnemy.instance()
	MonsterHandler.add_child(FairyEnemy2)
	get_node("EnemyPath/PathFollow/FairyEnemy")._change_state(3)
	ReRunSpawn = false
