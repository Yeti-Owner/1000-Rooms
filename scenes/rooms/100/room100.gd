extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
onready var FakeDoor = $Fader/FakeDoor/Door2/Door2/StaticBody
onready var FairyCage = $Fader/GlassCage
export(String) var _room 

var RoomStage = 0
var DoorStage = 0
var FairyEnemy = preload("res://scenes/enemies/FairyEnemy.tscn")
var Hatch = preload("res://scenes/objects/doors/Hatch.tscn")

func _ready():
	$Fader/ObjHolder/WallObj3/StaticBody/CollisionShape.disabled = true
	Narrator.connect("DialogueFinished", self, "_dialogue_finished")
	FakeDoor.connect("DoorOpened", self, "_door_triggered")
	FairyCage.connect("FairyReleased", self, "_release_fairy")
	SaveGame.game_data.RoomNum = 100
	SaveGame.game_data.LastCheckPoint = "res://scenes/rooms/100/room100.tscn"
	SaveGame.game_data.CurrentRoom = _room
	SaveGame._save()
	fader._fade_in()
	Narrator.messages = ["And here we are","a hub area is just up ahead","the hub is completely safe so feel free to explore as much as you desire"]
	RoomStage += 1

func _dialogue_finished():
	match RoomStage:
		1:
			get_node("Fader/ObjHolder/WallObj").queue_free()
			$BricksBreaking.play()
			Narrator.messages = ["But before you continue I need to share some info.","The next 100 rooms are much different from what you're used to.","They are much darker with different entrances","they are also much harder","...","I hope you're ready."]
			Narrator.start_dialogue()
			RoomStage += 1
		2:
			get_node("Fader/ObjHolder/WallObj2").queue_free()
			$BricksBreaking2.play()
			Narrator.messages = ["uh"]
			Narrator.start_dialogue()
			RoomStage += 1
		3:
			print("stage 3")


func _on_Area_area_entered(area):
	if area.name == "PlayerArea":
		Narrator.messages = ["I don't remember that","...","I wouldn't mess with it if I were you"]
		Narrator.start_dialogue()
		$Fader/ObjHolder/WallObj3.visible = true
		$Fader/ObjHolder/WallObj3/StaticBody/CollisionShape.set_deferred("disabled",  false)
		$Fader/TriggerArea.queue_free()

func _door_triggered():
	fader._fade_in()
	
	if DoorStage == 0:
		DoorStage += 1
		Narrator.messages = ["That's not good"]
		Narrator.start_dialogue()
	elif DoorStage == 1:
		DoorStage += 1
		Narrator.messages = ["That's really bad"]
		Narrator.start_dialogue()
	elif DoorStage == 2:
		DoorStage += 1
		Narrator.messages = ["You need to find a way out"]
		Narrator.start_dialogue()
	elif DoorStage == 6:
		DoorStage += 1
		Narrator.messages = ["I don't think you can just brute force this"]
		Narrator.start_dialogue()
	elif DoorStage == 11:
		DoorStage += 1
		Narrator.messages = ["Did the ghost give you brain damage?","Just going through the door isn't going to help"]
		Narrator.start_dialogue()
	elif DoorStage == 16:
		DoorStage += 1
		Narrator.messages = ["I hate you"]
		Narrator.start_dialogue()
	elif DoorStage == 21:
		DoorStage += 1
		Narrator.messages = ["Stuff like this is why you're trapped in this dungeon"]
		Narrator.start_dialogue()
	elif DoorStage == 28:
		DoorStage += 1
		Narrator.messages = ["I hope you have a bad day"]
		Narrator.start_dialogue()
	elif DoorStage == 37:
		DoorStage += 1
		Narrator.messages = ["Honestly","...","fuck you"]
		Narrator.start_dialogue()
	elif DoorStage == 45:
		DoorStage += 1
		Narrator.messages = ["Go through that Goddamned door one more time and I will kill you I swear to God"]
		Narrator.start_dialogue()
	elif DoorStage == 46:
		SaveGame.game_data.PlayerHP = 0
	else:
		DoorStage += 1

func _release_fairy():
	var FairyEnemy2 = FairyEnemy.instance()
	FairyEnemy2.transform.origin = Vector3(0, 1, -51.3)
	add_child(FairyEnemy2)
	
	var Hatch2 = Hatch.instance()
	Hatch2.transform.origin = Vector3(0, 0, -32.3)
	get_node("Fader").add_child(Hatch2)
	
	$Fader/FakeDoor.queue_free()
	
	get_node("Fader/ObjHolder/WallObj3").queue_free()
	$BricksBreaking2.play()
	
	Narrator.messages = ["UH OH","IT'S LOOSE","FIND THE HATCH TO ESCAPE"]
	Narrator.start_dialogue()
