extends Spatial

export(String) var _room 
var RNG

onready var fader = $Fader
onready var Narrator = $Narrator
onready var Monster = $Navigation/GhostEnemy
onready var player = get_node("/root/world/Fader/Player")


func _ready():
	randomize()
	_add_objs()
	get_node("ObjHolder/WallObj3").queue_free()
	get_node("ObjHolder/WallObj4").queue_free()
	SaveGame._save()
	fader._fade_in()
	Monster.transform.origin = Vector3(0, 3, 9)
	SaveGame.game_data.CurrentRoom = _room
	# if completed room
	if SaveGame.game_data.CurrentPos == Vector3(7.9, 5, -65.8):
		SaveGame.game_data.RoomNum = 50
		SaveGame.game_data.LastCheckPoint = "res://scenes/rooms/100/room50.tscn"
		$AreaHolder/Check3.queue_free()
		Monster.queue_free()
		player.transform.origin = Vector3(SaveGame.game_data.CurrentPos)
		Narrator.messages = ["Welcome back"]
	else: # if not
		get_node("ObjHolder/WallObj").visible = false
		get_node("ObjHolder/WallObj/StaticBody/CollisionShape").disabled = true
		Narrator.messages = ["Run", "you need to run"]

func _add_objs():
	for _i in $Objs.get_children():
		RNG = randi() % 10
		if RNG == 0:
			_i.visible = true
			print(_i)


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

func _on_Check4_area_entered(area4):
	if area4.name == "PlayerArea":
		$BricksBreaking.play()
		$AreaHolder/Check4.queue_free()
		$ObjHolder/WallObj2.queue_free()
		Narrator.messages = ["It's back"]
		Narrator.start_dialogue()
		Monster.transform.origin = Vector3(-29.2, -2.475, -38.136)
		Monster.speed = 10

func _on_Check5_area_entered(area5):
	if area5.name == "PlayerArea":
		Monster.transform.origin = Vector3(0, 3, 4.6)
		$AreaHolder/Check5.queue_free()
		Narrator.messages = ["STOP", "STAND STILL","Maybe we lost him?"]
		Narrator.start_dialogue()

func _on_Check6_area_entered(area6):
	if area6.name == "PlayerArea":
		Monster.transform.origin = Vector3(-42.8, 9.825, -41.936)
		Monster.speed = 8
		$AreaHolder/Check6.queue_free()

func _on_Check7_area_entered(area7):
	if area7.name == "PlayerArea":
		Narrator.messages = ["Don't"]
		Narrator.start_dialogue()
		$AreaHolder/Check7.queue_free()

func _on_Check8_area_entered(area):
	if area.name == "PlayerArea":
		$WoodBreaking.play()
		$AreaHolder/Check8.queue_free()
		$AreaHolder/Check9.queue_free()
		$ObjHolder/FloorObj9pt2.queue_free()
		Narrator.messages = ["It doesn't want you to escape","and I don't just mean the monster"]
		Narrator.start_dialogue()

func _on_Check9_area_entered(area):
	if area.name == "PlayerArea":
		$WoodBreaking.play()
		$AreaHolder/Check8.queue_free()
		$AreaHolder/Check9.queue_free()
		$ObjHolder/FloorObj9.queue_free()
		Narrator.messages = ["It doesn't want you to escape","and I don't just mean the monster"]
		Narrator.start_dialogue()

func _on_Check10_area_entered(area):
	if area.name == "PlayerArea":
		$AreaHolder/Check10.queue_free()
		$ObjHolder/FloorObj11.transform.origin = Vector3(-44, 2, -37.9)

func _on_Timer_timeout():
	Monster.queue_free()
	Narrator.messages = ["You're safe now", "take this time to look around before leaving"]
	Narrator.start_dialogue()


func _on_KillBox1_area_entered(kill1):
	if kill1.name == "PlayerArea":
		player._die()


func _on_KillBox2_area_entered(kill2):
	if kill2.name == "PlayerArea":
		player._die()


func _on_Check11_area_entered(area):
	if area.name == "PlayerArea":
		player.transform.origin = Vector3(51.09, 5.07, -112.6)
		

