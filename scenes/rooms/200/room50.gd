extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
onready var player = $Fader/Player
export(String) var _room 
var DoorStage = 1
var CorrectDoor
var lost = 0

func _ready():
	SaveGame.game_data.PlayerHP += 5
	randomize()
	$Narrator.connect("DialogueFinished", self, "_dialogue_finished")
	SaveGame.game_data.CurrentRoom = _room
	fader._fade_in()
	
	if SaveGame.game_data.CurrentPos == Vector3(67, 0.8, 13):
		Narrator.messages = ["You okay? you don't look too good."]
		player.global_transform.origin = Vector3(67, 0.8, 13)
		$Fader/Medkit.queue_free()
		$Fader/Medkit2.queue_free()
		$Fader/Medkit3.queue_free()
		$Fader/DoorReward.queue_free()
	else:
		Narrator.messages = ["Welcome welcome to room 250!","To your left are 3 doors, only 1 leads onwards, the other 2 to certain death.","All doors are equally likely to be the correct door.","Go ahead and choose one."]


func _first_door(door):
	match door:
		1:
			Narrator.messages = ["But lets not be too hasty, one last hint before you make your choice.","I will reveal that door C is NOT the correct door.","Now the choice is to stick with door A or change to door B."]
			Narrator.start_dialogue()
			get_node("Fader/ObjHolder/DoorC").queue_free()
			CorrectDoor = 2
		2:
			Narrator.messages = ["But lets not be too hasty, one last hint before you make your choice.","I will reveal that door A is NOT the correct door.","Now the choice is to stick with door B or change to door C."]
			Narrator.start_dialogue()
			get_node("Fader/ObjHolder/DoorA").queue_free()
			CorrectDoor = 3
		3:
			Narrator.messages = ["But lets not be too hasty, one last hint before you make your choice.","I will reveal that door B is NOT the correct door.","Now the choice is to stick with door C or change to door A."]
			Narrator.start_dialogue()
			get_node("Fader/ObjHolder/DoorB").queue_free()
			CorrectDoor = 1

func _second_door(door):
	match door:
		1:
			if CorrectDoor == 1:
				player.global_transform.origin = Vector3(78, 0.7, 19.6)
			else:
				_lose()
		2:
			if CorrectDoor == 2:
				player.global_transform.origin = Vector3(78, 0.7, 19.6)
			else:
				_lose()
		3:
			if CorrectDoor == 3:
				player.global_transform.origin = Vector3(78, 0.7, 19.6)
			else:
				_lose()

func _lose():
	lost = 1
	SaveGame.game_data.PlayerHP = 1
	Narrator.messages = ["Let's try that again shall we?"]
	Narrator.start_dialogue()

func _dialogue_finished():
	if lost == 1:
		get_tree().reload_current_scene()
