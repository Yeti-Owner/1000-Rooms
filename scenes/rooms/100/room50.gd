extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
onready var Monster = $Navigation/GhostEnemy

export(String) var _room 

func _ready():
	get_node("ObjHolder/WallObj").visible = false
	get_node("ObjHolder/WallObj/StaticBody/CollisionShape").disabled = true
	Settingsholder.CurrentRoom = _room
	fader._fade_in()
	Narrator.messages = ["Run", "you need to run"]
	Monster.transform.origin = Vector3(0, 3, 4.6)



func _on_Check1_area_entered(area1):
	if area1.name == "PlayerArea":
		Monster.transform.origin = Vector3(-1.5, 2.3, -24.3)


func _on_Check2_area_entered(area2):
	if area2.name == "PlayerArea":
		Monster.transform.origin = Vector3(-14.6, 4.5, -29.4)


func _on_Check3_area_entered(area3):
	if area3.name == "PlayerArea":
		get_node("ObjHolder/WallObj").visible = true
		get_node("ObjHolder/WallObj/StaticBody/CollisionShape").set_deferred("disabled",  false)
		Narrator.messages = ["take this time to heal up and maybe look around before leaving", "You're safe here now", "you can trust me"]
		Narrator.start_dialogue()
