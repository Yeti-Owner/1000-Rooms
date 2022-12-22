extends Spatial

export(Environment) var EnvironmentUsed

onready var Narrator = $Narrator
onready var FakeDoor = $RoomItems/FakeDoor/StaticBody
onready var FairyCage = $RoomItems/GlassCage
onready var player = get_node("RoomItems/Player")
onready var _room = self.filename

var RNG
var RoomStage = 0
var DoorStage = 0
var FairyEnemy = preload("res://scenes/enemies/FairyEnemy.tscn")
var Hatch = preload("res://scenes/objects/doors/Hatch.tscn")

func _ready():
	randomize()
	SceneManager.GameScene.world.set_environment(EnvironmentUsed)
	_add_objs()
	SaveGame.game_data.CurrentRoom = _room
	Narrator.connect("DialogueFinished", self, "_dialogue_finished")
	FakeDoor.connect("DoorOpened", self, "_door_triggered")
	FairyCage.connect("FairyReleased", self, "_release_fairy")
	
	# Check if Asshole Achievement done
	if AchievementsHolder.game_data.Asshole:
		$RoomItems/BlockedDoor.visible = true
		$RoomItems/BlockedDoor.global_transform.origin = Vector3(0,0,-55.98)
		$RoomItems/FakeDoor.global_transform.origin = Vector3(0,0,-59.98)
	else:
		$RoomItems/BlockedDoor.queue_free()
	
	if SaveGame.game_data.CurrentPos == Vector3(4, 0.7, -21.5):
		player.transform.origin = Vector3(4, 0.7, -21.5)
	$RoomItems/WallObj3.global_transform.origin = Vector3(0, 5, 0)
	Narrator.messages = ["And here we are","a hub area is just up ahead","the hub is completely safe so feel free to explore as much as you desire"]
	RoomStage += 1

func _add_objs():
	for _i in $Objs.get_children():
		RNG = randi() % 10
		if RNG == 0:
			_i.visible = true
		else:
			_i.queue_free()

func _dialogue_finished():
	match RoomStage:
		1:
			get_node("RoomItems/WallObj").queue_free()
			$BricksBreaking.play()
			Narrator.messages = ["But before you continue I need to share some info.","The next 100 rooms are much different from what you're used to.","They are much darker with different entrances","they are also much harder","...","I hope you're ready."]
			Narrator.start_dialogue()
			RoomStage += 1
		2:
			get_node("RoomItems/WallObj2").queue_free()
			$BricksBreaking2.play()
			Narrator.messages = ["uh"]
			Narrator.start_dialogue()
			RoomStage += 1

func _on_Area_area_entered(area):
	if area.name == "PlayerArea":
		Narrator.messages = ["I don't remember that","...","I wouldn't mess with it if I were you"]
		Narrator.start_dialogue()
		$RoomItems/WallObj3.visible = true
		$RoomItems/WallObj3.global_transform.origin = Vector3(0, 0, 0)
		$RoomItems/TriggerArea.queue_free()

func _door_triggered():
	SceneManager._fade_in()
	
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
	elif DoorStage == 43:
		DoorStage += 1
		Narrator.messages = ["Go through that Goddamned door one more time and I will kill you I swear to God"]
		Narrator.start_dialogue()
	elif DoorStage == 44:
		if AchievementsHolder.game_data.Asshole == 0:
			AchievementsHolder.game_data.Asshole = 1
			AchievementsHolder._save()
			AchievementsHolder.emit_signal("NewAchievement")
		SaveGame.game_data.PlayerHP = 0
		SaveGame.DeathReason = "narrator"
	else:
		DoorStage += 1

func _release_fairy():
	$Timer.start()
	
	# Instance in Hatch
	var Hatch2 = Hatch.instance()
	Hatch2.transform.origin = Vector3(0, 0, -32.3)
	get_node("RoomItems").add_child(Hatch2)
	$ArrowSigns.visible = true
	$ArrowSigns.transform.origin = Vector3(-1.3,0,-32.4)
	
	# remove door and wall
	$RoomItems/FakeDoor.queue_free()
	get_node("RoomItems/WallObj3").queue_free()
	$BricksBreaking2.play()
	
	Narrator.messages = ["IT'S LOOSE","FIND THE HATCH TO ESCAPE"]
	Narrator.start_dialogue()

func _on_Timer_timeout():
	# instance in Fairy
	var FairyEnemy2 = FairyEnemy.instance()
	FairyEnemy2.transform.origin = Vector3(0, 1, -50.3) # 0,1,-51.3
	add_child(FairyEnemy2)
	get_node("FairyEnemy")._change_state(2)
