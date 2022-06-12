extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
onready var Monster = $Navigation/GhostEnemy
onready var player = get_node("/root/world/Fader/Player")

export(String) var _room 

func _ready():
	fader._fade_in()
	Monster.transform.origin = Vector3(0, 3, 4.6)
	SaveGame.game_data.CurrentRoom = _room
	if typeof(SaveGame.game_data.CurrentPos) == TYPE_VECTOR3:
		player.transform.origin = Vector3(SaveGame.game_data.CurrentPos)
		Narrator.messages = ["Welcome back"]
	else:
		get_node("ObjHolder/WallObj").visible = false
		get_node("ObjHolder/WallObj/StaticBody/CollisionShape").disabled = true
		Narrator.messages = ["Run", "you need to run"]



func _on_Check1_area_entered(area1):
	if area1.name == "PlayerArea":
		$AreaHolder/Check1.queue_free()
		Monster.transform.origin = Vector3(-1.5, 2.3, -24.3)


func _on_Check2_area_entered(area2):
	if area2.name == "PlayerArea":
		$AreaHolder/Check2.queue_free()
		Monster.transform.origin = Vector3(-14.6, 4.5, -29.4)


func _on_Check3_area_entered(area3):
	if area3.name == "PlayerArea":
		$AreaHolder/Check3.queue_free()
		get_node("ObjHolder/WallObj").visible = true
		get_node("ObjHolder/WallObj/StaticBody/CollisionShape").set_deferred("disabled",  false)
		$Timer.start()


func _on_Timer_timeout():
	Narrator.messages = ["You're safe now", "take this time to look around before leaving", "you can trust me"]
	Narrator.start_dialogue()


func _on_KillBox1_area_entered(kill1):
	if kill1.name == "PlayerArea":
		player._die()


func _on_KillBox2_area_entered(kill2):
	if kill2.name == "PlayerArea":
		player._die()
