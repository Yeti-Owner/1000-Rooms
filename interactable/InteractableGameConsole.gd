extends Interactable

# References
var Player
var PlayerCam
var GUI
onready var viewport = $ViewportManager/Viewport
onready var Screen = $ViewportManager/Screen
onready var Collision2 = $CollisionShape2
var Menu

# Constants for Instancing
const PlayerScene = preload("res://scenes/Player.tscn")
const GUIScene = preload("res://scenes/UI/GUI.tscn")

var Interacted = 0
var Stage = 0
onready var GameRot = $Position3D.global_transform.basis
onready var TestRotation = $RotationPos.global_transform.basis

# PlayerVars
var CamLoc
var GameLoc
var CamRot
var CamFOV
var NewCam
var PlayerLoc

func get_interaction_text():
	return "Press E to play"

func interact():
	if Interacted == 0:
		Interacted = 1
		
		# Manage Vars
		Player = get_node("/root/world/Fader/Player")
		PlayerCam = get_node("/root/world/Fader/Player/CameraHolder/Camera")
		GUI = get_node("/root/world/Fader/GUI")
		NewCam = Camera.new()
		Menu = $ViewportManager/Viewport/Menu
		
		# Add in New Cam
		add_child(NewCam)
		NewCam.set_fov(Settingsholder.PlayerFOV)
		
		# Position/Rotate it correctly
		PlayerLoc = Player.global_transform.origin
		CamLoc = PlayerCam.global_transform.origin
		GameLoc = $Position3D.global_transform.origin
		CamRot = PlayerCam.global_transform.basis
		CamFOV = Settingsholder.PlayerFOV
		
		NewCam.global_transform.origin = CamLoc
		NewCam.global_transform.basis = CamRot
		NewCam.set_fov(CamFOV)
		
		# Remove old Player + GUI
		Player.queue_free()
		GUI.queue_free()
		
		# Move/Rotate new Cam
		$PlayerCamera.interpolate_property(NewCam, "global_transform:origin", CamLoc, GameLoc, 3, 0)
		$PlayerCamera.interpolate_property(NewCam, "global_transform:basis", CamRot, GameRot, 3, 0)
		$PlayerCamera.interpolate_property(NewCam, "fov", CamFOV, 70, 3, 0)
		$PlayerCamera.start()
		Collision2.disabled = true
		Stage = 1


func _on_PlayerCamera_tween_completed(_object, _key):
	if Stage == 1:
		_ingame()
	elif Stage == 2:
		# Re-add GUI and Player
		var NewPlayer = PlayerScene.instance()
		var NewGUI = GUIScene.instance()
		get_node("/root/world/Fader").add_child(NewGUI)
		get_node("/root/world/Fader").add_child(NewPlayer)
		NewCam.queue_free()
		NewPlayer.global_transform.origin = PlayerLoc
		NewPlayer.global_transform.basis = TestRotation
		Screen.material_override.albedo_texture = null
		Collision2.disabled = false
		Stage = 0
		Interacted = 0
		get_tree().paused = false


func _ingame():
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
