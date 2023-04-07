extends Node3D

@export(NodePath) onready var Removable
@export var EnvironmentUsed: Environment
@export var room_event: Resource
@export var AllowEnemy:bool = true
@onready var Narrator := $Narrator
@onready var _room := self.filename

var RemovableList := ["Good job","Congrats","Well Done","I knew you could do it","You could've done it faster","Lets not waste any more time","Next time try doing it faster","I'm very proud of you and your ability to hit glowing orbs","have you tried walking... but faster?"]

func _ready():
	randomize()
	SceneManager.GameScene.world.environment = EnvironmentUsed
	SaveGame.game_data.CurrentRoom = _room
	_room_event()
	_add_objs()
	SaveGame._update_presence()

#func _check_room():
#	if (SaveGame.game_data.FirstTimeAcid) && (_room == "res://scenes/rooms/300/room1.tscn" or _room == "res://scenes/rooms/300/room4.tscn" or _room == "res://scenes/rooms/300/room14.tscn"):
#		Narrator.messages = ["Be mindful of the acid.","It's not just for show"]
#		SaveGame.game_data.FirstTimeAcid = 0
#	elif (_room == "res://scenes/rooms/300/room3.tscn" or _room == "res://scenes/rooms/300/room8.tscn") && (SaveGame.game_data.FirstTimeLights):
#		Narrator.messages = ["Don't be afraid","those orbs won't hurt you.","Quite the opposite actually, you need to grab them all to progress."]
#		SaveGame.game_data.FirstTimeLights = 0
#		AllowEnemy = 0
#	elif _room == "res://scenes/rooms/300/room5.tscn" && SaveGame.game_data.FirstTimeRoom305:
#		Narrator.messages = ["This room is very confusing.","I wish you the best but I'm not sure I understand this room myself."]
#		SaveGame.game_data.FirstTimeRoom305 = 0
#		AllowEnemy = 0
#	elif _room == "res://scenes/rooms/300/room6.tscn" && SaveGame.game_data.FirstTimeRoom306:
#		Narrator.messages = ["Not sure what went wrong with this room.","Hope you weren't hurt by your fall though."]
#		SaveGame.game_data.FirstTimeRoom306 = 0
#		AllowEnemy = 0
#	elif _room == "res://scenes/rooms/300/room9.tscn" && SaveGame.game_data.FirstTimeRoom309:
#		Narrator.messages = ["Be wary of optical illusions.","The dungeon loves to play tricks on the mind."]
#		SaveGame.game_data.FirstTimeRoom309 = 0
#		AllowEnemy = 0
#	elif (_room == "res://scenes/rooms/300/room10.tscn" or _room == "res://scenes/rooms/300/room11.tscn" or _room == "res://scenes/rooms/300/room15.tscn") && (SaveGame.game_data.FirstTimeConfusing300):
#		Narrator.messages = ["Just as I expected.","The Dungeon will try to confuse you at every opportunity.","Keep your wits about you."]
#		SaveGame.game_data.FirstTimeConfusing300 = 0
#		AllowEnemy = 0
#	elif _room == "res://scenes/rooms/300/room12.tscn" && SaveGame.game_data.FirstTimeConfusing312:
#		Narrator.messages = ["This room is a bit of an IQ test.","Please don't listen to the signs."]
#		SaveGame.game_data.FirstTimeConfusing312 = 0

func _room_event():
	if not room_event:
		return
	if (room_event.on_number != -1) and (room_event.on_number != SaveGame.game_data.RoomNum):
		if room_event.table_remove:
			get_node(room_event.table_path).queue_free()
	if (room_event.first_time) and (SaveGame.game_data[room_event.var_used] == 0):
		return
	if room_event.narrator_text.size() > 0: Narrator.messages = room_event.narrator_text
	AllowEnemy = room_event.enemy_allowed
	if room_event.var_used != null:
		SaveGame.game_data[room_event.var_used] = 0

func _add_objs():
	for _i in $Objs.get_children():
		var RNG := randi() % 3
		if RNG != 0:
			_i.queue_free()

func _lights_complete():
	get_node(Removable).queue_free()
	Narrator.messages = [RemovableList[randi() % RemovableList.size()]]
	Narrator.start_dialogue()
