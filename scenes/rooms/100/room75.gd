extends Spatial

export(Environment) var EnvironmentUsed

onready var Narrator := $Narrator
onready var Objs := $Objs
onready var player := $RoomItems/Player
onready var _room := self.filename

var Ending:String
var MovePos:Vector3

func _ready():
	SceneManager.GameScene.world.set_environment(EnvironmentUsed)
	Narrator.connect("DialogueFinished", self, "_dialogue_finished")
	SaveGame.game_data.CurrentRoom = _room
	if SaveGame.game_data.CurrentPos == Vector3(7.731, 0.7, 45.853):
		Narrator.messages = ["Hello again."]
		player.global_transform.origin = Vector3(7.731, 0.7, 45.853)
	else:
		Narrator.messages = ["I'm afraid I can't help you in this room.","All I can tell you is to be very careful.","You will only get 1 chance to choose the correct hallway."]


func _on_Moth_area_entered(area):
	if area.name == "PlayerArea":
		Ending = "Moth"
		$RoomItems/AreaHolder.queue_free()
		Narrator.messages = ["Good job","Moths are mostly nocturnal hunters.","Additionally, they fear fire since it kills them and draws them in.","Moths are powerless to resist and know it will only lead to their demise."]
		Narrator.start_dialogue()
		MovePos = player.global_transform.origin
		MovePos.x = MovePos.x + 6
		MovePos.z = MovePos.z + 115.744
		player.global_transform.origin = MovePos

func _on_Tree_area_entered(area):
	if area.name == "PlayerArea":
		Ending = "Tree"
		$RoomItems/AreaHolder.queue_free()
		Narrator.messages = ["Really? a fuckin tree!?","Are you stupid?","How is a tree SWIFT huh!?"]
		Narrator.start_dialogue()

func _on_CuttleFish_area_entered(area):
	if area.name == "PlayerArea":
		Ending = "CuttleFish"
		$RoomItems/AreaHolder.queue_free()
		Narrator.messages = ["Really?","Cuttlefish?!","I don't even know what to say here.","Of all the choices to make you chose Cuttlefish?","How is a FISH afraid of fire?","...","I hate it here"]
		Narrator.start_dialogue()

func _on_Rhino_area_entered(area):
	if area.name == "PlayerArea":
		Ending = "Rhino"
		$RoomItems/AreaHolder.queue_free()
		Narrator.messages = ["Rhino?","Have you ever watched national geographic?","Rhinos hate fire, they stomp it out whenever they see it.","They're not exactly afraid of something that barely touches them."]
		Narrator.start_dialogue()

func _dialogue_finished():
	match Ending:
		"Moth":
			pass
		"Tree":
			SaveGame.game_data.PlayerHP = 1
			SceneManager._reload_scene()
		"CuttleFish":
			SaveGame.game_data.PlayerHP = 1
			SceneManager._reload_scene()
		"Rhino":
			SaveGame.game_data.PlayerHP = 1
			SceneManager._reload_scene()
