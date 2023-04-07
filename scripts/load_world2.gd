extends Node3D

@export var AllowChase: bool := true
@export var EnvironmentUsed: Environment
@export var room_event: Resource
@onready var Narrator := $Narrator
@onready var MonsterHandler := $EnemyPath/PathFollow3D
@onready var _room := self.filename

#var FairyEnemy := preload("res://scenes/enemies/FairyEnemy.tscn")
var ChaseList := ["HURRY!","IT'S HERE!","RUN!","HIDE!"]
var ReRunSpawn:bool = true

func _ready():
	$ReflectionProbe.intensity = 0.01
# warning-ignore:return_value_discarded
	$Narrator.connect("DialogueFinished",Callable(self,"_dialogue_finished"))
	randomize()
	SceneManager.GameScene.world.environment = EnvironmentUsed
	SaveGame.game_data.CurrentRoom = _room
	if _room == "res://scenes/rooms/200/room12.tscn": _check_room()
	_room_event()
	_add_objs()
	SaveGame._update_presence()

func _check_room():
	match SaveGame.game_data.FirstTimeRoom212:
		1:
			Narrator.messages = ["I'm quite sorry I don't remember leaving all this junk around.","Do the opposite of what the signs say,","I don't even remember what is written"]
			SaveGame.game_data.FirstTimeRoom212 = 2
		2:
			Narrator.messages = ["Again I'm very sorry","Most of the signs should be cleaned up now"]
			get_node("RoomItems/Plaque2").queue_free()
			get_node("RoomItems/Plaque4").queue_free()
			get_node("RoomItems/Plaque6").queue_free()
			SaveGame.game_data.FirstTimeRoom212 = 3
		3:
			get_node("RoomItems/Plaque2").queue_free()
			get_node("RoomItems/Plaque4").queue_free()
			get_node("RoomItems/Plaque6").queue_free()

func _room_event():
	if not room_event:
		return
	if (room_event.on_number != -1) and (room_event.on_number != SaveGame.game_data.RoomNum):
		if room_event.table_remove:
			get_node(room_event.table_path).queue_free()
	if (room_event.first_time) and (SaveGame.game_data[room_event.var_used] == 0):
		return
	if room_event.narrator_text.size() > 0: Narrator.messages = room_event.narrator_text
	AllowChase = room_event.enemy_allowed
	if room_event.var_used != null:
		SaveGame.game_data[room_event.var_used] = 0

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
			$SpawnTimer.wait_time = 4.5
			$SpawnTimer.start()
			ReRunSpawn = false
			if SaveGame.isChased == 0:
				SaveGame.isChased = 3
			else:
				SaveGame.isChased -= 1

func _on_SpawnTimer_timeout():
	$RoomItems/wall.queue_free()
	var FairyEnemy = load("res://scenes/enemies/FairyEnemy.tscn").instantiate()
	MonsterHandler.add_child(FairyEnemy)
	get_node("EnemyPath/PathFollow3D/FairyEnemy")._change_state(3)
	ReRunSpawn = false
