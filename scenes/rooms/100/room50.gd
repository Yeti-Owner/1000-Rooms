extends Node3D

@export var EnvironmentUsed: Environment
@onready var Narrator := $Narrator
@onready var Monster := $NavMesh/GhostEnemy
@onready var player := get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player")
@onready var _room:String = self.get_scene_file_path()

func _ready():
	randomize()
#	SceneManager.GameScene.world.set_environment(EnvironmentUsed)
	_add_objs()
	get_node("ObjHolder/WallObj3").queue_free()
	get_node("ObjHolder/WallObj4").queue_free()
	SaveGame.game_data.RoomNum = 50
	SaveGame.game_data.LastCheckPoint = _room
	SaveGame.game_data.CurrentRoom = _room
	SaveGame._save()
	SaveGame._update_presence()
	Monster.transform.origin = Vector3(0, 1.623, 9)
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
		get_node("ObjHolder/WallObj").position = Vector3(0, -4.1, 0)
		Narrator.messages = ["Run", "you need to run"]

func _add_objs():
	for _i in $Objs.get_children():
		var RNG = randi() % 10
		if RNG == 0:
			_i.visible = true
		else:
			_i.queue_free()


func _on_Check1_area_entered(area1):
	if area1.name == "PlayerArea":
		$AreaHolder/Check1.queue_free()
		Monster.transform.origin = Vector3(-1.5, 1.923, -24.3)


func _on_Check2_area_entered(area2):
	if area2.name == "PlayerArea":
		$AreaHolder/Check2.queue_free()
		Monster.transform.origin = Vector3(-14.6, 3.623, -28)


func _on_Check3_area_entered(area3):
	if area3.name == "PlayerArea":
		$AreaHolder/Check3.queue_free()
		get_node("ObjHolder/WallObj").position = Vector3(0,0,0)
		$Timer.start()

func _on_Check4_area_entered(area4):
	if area4.name == "PlayerArea":
		$BricksBreaking.play()
		$AreaHolder/Check4.queue_free()
		$ObjHolder/WallObj2.queue_free()
		Narrator.messages = ["It's back"]
		Narrator.start_dialogue()
		Monster.transform.origin = Vector3(-29.2, -2.852, -38.136)
		Monster.speed = 10

func _on_Check5_area_entered(area5):
	if area5.name == "PlayerArea":
		Monster.transform.origin = Vector3(0, 1, 4.6)
		$AreaHolder/Check5.queue_free()
		Narrator.messages = ["Maybe we lost him?"]
		Narrator.start_dialogue()

func _on_Check6_area_entered(area6):
	if area6.name == "PlayerArea":
		Monster.transform.origin = Vector3(-42.8, 9.448, -41.936)
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
		$ObjHolder/FloorObj11.transform.origin.z -= 0.9

func _on_Timer_timeout():
	Monster.queue_free()
	Narrator.messages = ["You're safe now", "take this time to look around before leaving"]
	Narrator.start_dialogue()

func _on_KillBox1_area_entered(kill1):
	if kill1.name == "PlayerArea":
		SaveGame.DeathReason = "fall"
		SaveGame.game_data.PlayerHP -= 5
		SceneManager._reload_scene()

func _on_KillBox2_area_entered(kill2):
	if kill2.name == "PlayerArea":
		SaveGame.DeathReason = "fall"
		SaveGame.game_data.PlayerHP -= 5
		SceneManager._reload_scene()

func _on_Check11_area_entered(area):
	if area.name == "PlayerArea":
		player.transform.origin = Vector3(51.09, 5.07, -112.6)
		if AchievementsHolder.game_data.FormagDrung == 0:
			AchievementsHolder.game_data.FormagDrung = 1
			AchievementsHolder._save()
			AchievementsHolder.emit_signal("NewAchievement")

