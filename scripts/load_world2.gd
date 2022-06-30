extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
onready var MonsterHandler = $EnemyPath/PathFollow
export(String) var _room 
export(bool) var AllowChase = true
var FairyEnemy = preload("res://scenes/enemies/FairyEnemy.tscn")
var RNG
var ReRunSpawn = 1

func _ready():
	$Narrator.connect("DialogueFinished", self, "_dialogue_finished")
	randomize()
	SaveGame.game_data.CurrentRoom = _room
	fader._fade_in()
	_check_room()

func _check_room():
	if _room == "res://scenes/rooms/200/room10.tscn" && SaveGame.FirstTimeRoom210:
		AllowChase = false
		Narrator.messages = ["I don't remember making this room", "This may be bad","But no fear, all rooms are created to be possible."]
		SaveGame.FirstTimeRoom210 = 0
	elif _room == "res://scenes/rooms/200/room8.tscn" && SaveGame.FirstTimeParkour:
		AllowChase = false
		Narrator.messages = ["Hope you're ready for some parkour"]
		SaveGame.FirstTimeParkour = 0
	elif _room == "res://scenes/rooms/200/room11.tscn" && SaveGame.FirstTimeRoom211:
		AllowChase = false
		Narrator.messages = ["I'm terribly sorry but I do enjoy making large rooms"]
		SaveGame.FirstTimeRoom211 = 0
	elif _room == "res://scenes/rooms/200/room12.tscn" && (SaveGame.FirstTimeRoom212 == 1):
		AllowChase = false
		Narrator.messages = ["I'm quite sorry I don't remember leaving all this junk around.","Do the opposite of what the signs say,","I don't even remember what is written"]
		SaveGame.FirstTimeRoom212 = 2
	elif _room == "res://scenes/rooms/200/room12.tscn" && (SaveGame.FirstTimeRoom212 == 2):
		AllowChase = false
		Narrator.messages = ["Again I'm very sorry","Most of the signs should be cleaned up now"]
		get_node("root/world/Fader/Plaque2").queue_free()
		get_node("root/world/Fader/Plaque4").queue_free()
		get_node("root/world/Fader/Plaque6").queue_free()
		SaveGame.FirstTimeRoom212 = 0
	elif _room == "res://scenes/rooms/200/room13.tscn" && SaveGame.FirstTimeRoom213:
		Narrator.messages = ["Oh","...","this room isn't very fun"]
		SaveGame.FirstTimeRoom213 = 0
	elif _room == "res://scenes/rooms/200/room14.tscn" && SaveGame.FirstTimeRoom214:
		AllowChase = false
		Narrator.messages = ["This may require some trial and error but I believe in you!"]
		SaveGame.FirstTimeRoom214 = 0
	elif _room == "res://scenes/rooms/200/room15.tscn" && SaveGame.FirstTimeRoom215:
		Narrator.messages = ["Before you begin...","I'd like you to know I'm sorry"]
		SaveGame.FirstTimeRoom215 = 0

func _dialogue_finished():
	if ReRunSpawn == 1:
		_chasing()

#func _add_objs():
#	pass

func _chasing():
	if AllowChase:
		RNG = randi() % 2
		if (RNG == 0):
			Narrator.messages = ["HURRY"]
			Narrator.start_dialogue()
			$SpawnTimer.start()
			ReRunSpawn = 0


func _on_SpawnTimer_timeout():
	$Fader/wall.queue_free()
	var FairyEnemy2 = FairyEnemy.instance()
	MonsterHandler.add_child(FairyEnemy2)
	get_node("EnemyPath/PathFollow/FairyEnemy")._change_state(3)
	ReRunSpawn = 0
