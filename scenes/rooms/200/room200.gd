extends Spatial

export(Environment) var EnvironmentUsed

onready var Narrator = $Narrator
onready var _room = self.filename
var stage = 0

func _ready():
	randomize()
	SceneManager.GameScene.world.environment = EnvironmentUsed
	Narrator.connect("DialogueFinished", self, "_dialogue_finished")
	SaveGame.game_data.CurrentRoom = _room
	SaveGame._update_presence()
	Narrator.messages = ["Welcome welcome to room 200.","Same as before things are about to change."]

func _dialogue_finished():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
