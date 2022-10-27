extends Spatial

export(Environment) var Environment1

onready var Narrator := $Narrator
onready var _room := self.filename
onready var DialoguePause := $DialoguePause
var stage = 0

func _ready():
	randomize()
	SceneManager.GameScene.world.environment = Environment1
# warning-ignore:return_value_discarded
	Narrator.connect("DialogueFinished", self, "_dialogue_finished")
	SaveGame.game_data.CurrentRoom = _room
	SaveGame._update_presence()
	Narrator.messages = ["Welcome welcome to room 200.","Once again things are about to change, and unfortunately for the worse."]

func _dialogue_finished():
	match stage:
		0:
			$GridMap2/Walls.global_transform.origin.y = 20
			DialoguePause.wait_time = 1
			DialoguePause.start()
		1:
			DialoguePause.wait_time = 1
			DialoguePause.start()
		2:
			$HubGridmap/Walls.global_transform.origin.y = 20
		3:
			$GridMap3/Walls.queue_free()

func _on_DialoguePause_timeout():
	match stage:
		0:
			Narrator.messages = ["Wait as long here as necessary before you move on.","I'm in no rush to see you walk to your death."]
			Narrator.start_dialogue()
			stage = 1
		1:
			Narrator.messages = ["For the next 100 rooms light will be your best friend.","The beasts that haunt these rooms fear the light, including the light from your flashlight.","As long as you keep your flashlight with you and on you should be safe.","But don't unnecessarily taunt the monsters."]
			Narrator.start_dialogue()
			stage = 2
		2:
			Narrator.messages = ["Let me reiterate.","Rule 1: Don't mess with them.","Rule 2: Stay close to the light.","Rule 3: Use your flashlight if necessary.","Rule 4: Don't mess with them."]
			Narrator.start_dialogue()
			stage = 3

func _on_Sensor2_PlayerDetected():
	$GridMap2/Walls.global_transform.origin.y = 0
	

func _on_Sensor3_PlayerDetected():
	$HubGridmap/Walls.global_transform.origin.y = 0
	DialoguePause.wait_time = 1
	DialoguePause.start()

