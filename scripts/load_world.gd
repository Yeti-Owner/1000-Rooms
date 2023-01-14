extends Spatial

export(bool) var EnemyAllowed = true
export(Environment) var EnvironmentUsed

onready var Narrator := $Narrator
onready var Objs := $Objs
onready var _room := self.filename
 
func _ready():
	randomize()
	SceneManager.GameScene.world.environment = EnvironmentUsed
	_add_objs()
	SaveGame.game_data.CurrentRoom = _room
	_check_room()
	SaveGame._update_presence()
	_summon_enemy()

func _check_room():
	if _room == "res://scenes/world.tscn":
		Narrator.messages = ["Welcome to my dungeon", "it's a bit bigger on the inside","I wonder how far you'll make"]
		EnemyAllowed = false
	elif _room == "res://scenes/rooms/100/room13.tscn" && SaveGame.game_data.FirstTimeRoom13:
		Narrator.messages = ["This room is an interesting one", "I'll give you a hint though", "I'm not a fan of tedious puzzles.", "I'd rather just hide the solution in plain sight"]
		SaveGame.game_data.FirstTimeRoom13 = 0
		EnemyAllowed = false
	elif SaveGame.game_data.RoomNum == 18 and _room == "res://scenes/rooms/100/room1.tscn":
		$Table1.visible = true
		EnemyAllowed = false
	elif _room == "res://scenes/rooms/100/room1.tscn" and SaveGame.game_data.RoomNum != 18:
		$Table1.queue_free()
	elif SaveGame.game_data.RoomNum == 30 and _room == "res://scenes/rooms/100/room10.tscn":
		$Table2.visible = true
		EnemyAllowed = false
	elif _room == "res://scenes/rooms/100/room10.tscn" and SaveGame.game_data.RoomNum != 30:
		$Table2.queue_free()
	elif SaveGame.game_data.RoomNum == 49:
		$HandPrints.visible = true
	elif _room == "res://scenes/rooms/100/room14.tscn" and SaveGame.game_data.RoomNum == 56:
		$Table3.visible = true
		EnemyAllowed = false
	elif _room == "res://scenes/rooms/100/room14.tscn" and SaveGame.game_data.RoomNum != 56:
		$Table3.queue_free()

func _add_objs():
	for _i in Objs.get_children():
		var RNG := randi() % 5
		if RNG == 0:
			_i.visible = true
		else:
			_i.queue_free()

func _summon_enemy():
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	if EnemyAllowed:
		var RNG := randi() % 5
		if RNG == 0 or SaveGame.isChased > 0:
			get_node("NavMesh/EnemySpawner")._summon()
			if SaveGame.isChased == 0:
				SaveGame.isChased = 5
			else:
				SaveGame.isChased -= 1
