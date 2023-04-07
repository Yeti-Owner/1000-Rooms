extends Interactable

# References
var Player
var PlayerCam
var GUI
@onready var viewport = $ViewportManager/SubViewport
@onready var Screen = $ViewportManager/Screen
@onready var Collision2 = $CollisionShape2
var Menu

# Constants for Instancing
const PlayerScene = preload("res://scenes/Player.tscn")
const GUIScene = preload("res://scenes/UI/GUI.tscn")

var Interacted = 0
var Stage = 0
@onready var GameRot = $Marker3D.global_transform.basis
@onready var TestRotation = $RotationPos.global_transform.basis
@onready var world = get_node("/root/SceneManager/GameScene/GameViewport/world")

# PlayerVars
var CamLoc
var GameLoc
var CamRot
var CamFOV
var NewCam
var PlayerLoc

func _ready():
	self.queue_free()

func get_interaction_text():
	return "Press %s to play" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)]

func interact():
	if Interacted == 0:
		Interacted = 1
		
		# Manage Vars
		Player = get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player")
		PlayerCam = get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player/CameraHolder/Camera3D")
		NewCam = Camera3D.new()
		Menu = $ViewportManager/SubViewport/Menu
		
		# Add in New Cam
		add_child(NewCam)
		NewCam.set_fov(Settingsholder.save_data.PlayerFOV)
		
		# Position/Rotate it correctly
		PlayerLoc = Player.global_transform.origin
		CamLoc = PlayerCam.global_transform.origin
		GameLoc = $Marker3D.global_transform.origin
		CamRot = PlayerCam.global_transform.basis
		CamFOV = Settingsholder.save_data.PlayerFOV
		
		NewCam.global_transform.origin = CamLoc
		NewCam.global_transform.basis = CamRot
		NewCam.set_fov(CamFOV)
		
		# Remove old Player + GUI 
		Player.queue_free()
		SceneManager.HudMode = "none"
		
		# Move/Rotate new Cam
		$PlayerCamera.interpolate_property(NewCam, "global_transform:origin", CamLoc, GameLoc, 3, 0)
		$PlayerCamera.interpolate_property(NewCam, "global_transform:basis", CamRot, GameRot, 3, 0)
		$PlayerCamera.interpolate_property(NewCam, "fov", CamFOV, 70, 3, 0)
		$PlayerCamera.start()
		Collision2.disabled = true
		Stage = 1
		
		# Fix Mouse Settings in SceneManager
		get_node("/root/SceneManager/GameScene").mouse_filter = 2



func _on_PlayerCamera_tween_completed(_object, _key):
	if Stage == 1:
		_ingame()
	elif Stage == 2:
		# Re-add GUI and Player
		SceneManager.HudMode = "ingame"
		var NewPlayer = PlayerScene.instantiate()
		get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems").add_child(NewPlayer)
		NewCam.queue_free()
		NewPlayer.global_transform.origin = PlayerLoc
		NewPlayer.global_transform.basis = TestRotation
		NewPlayer.scale = Vector3(0.6, 0.6, 0.6)
		Screen.material_override.albedo_texture = null
		Collision2.disabled = false
		Stage = 0
		Interacted = 0 
		get_tree().paused = false
		get_node("/root/SceneManager/GameScene").mouse_filter = 0
		_fix_viewport()


func _ingame():
	get_node("/root/SceneManager/GameScene/GameViewport").set_size(Vector2(1920,1080))
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Screen.material_override.albedo_texture = viewport.get_texture()
	Menu._active()

func _exit_game():
	# Set up Tweens for exiting.
		$PlayerCamera.interpolate_property(NewCam, "global_transform:origin", GameLoc, CamLoc, 3, 0)
		$PlayerCamera.interpolate_property(NewCam, "global_transform:basis", GameRot, TestRotation, 3, 0)
		$PlayerCamera.interpolate_property(NewCam, "fov", 70, CamFOV, 3, 0)
		$PlayerCamera.start()
		Stage = 2

func _on_DisableEnemy_timeout():
	# Disable Enemy spawning if node exists
	if "EnemyAllowed" in world:
		world.EnemyAllowed = false
	elif "AllowChase" in world:
		world.AllowChase = false
	elif "AllowEnemy" in world:
		world.AllowEnemy = false

func _fix_viewport():
	var Resolutions = [Vector2(848,480), Vector2(960,540), Vector2(1024,576), Vector2(1280,720), Vector2(1366,768), Vector2(1600,900), Vector2(1920,1080), Vector2(2560,1440)]
	get_node("/root/SceneManager/GameScene/GameViewport").set_size(Resolutions[Settingsholder.save_data.ResolutionScale])
