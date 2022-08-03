extends Interactable

onready var Player = get_node("/root/world/Fader/Player")
onready var PlayerCam = get_node("/root/world/Fader/Player/CameraHolder/Camera")
onready var GUI = get_node("/root/world/Fader/GUI")
onready var viewport = $ViewportManager/Viewport
onready var Screen = $ViewportManager/Screen
onready var Menu = $ViewportManager/Viewport/Menu

var Interacted = 0
export(Basis) var GameRot

func get_interaction_text():
	return "Press E to play"

func interact():
	if Interacted == 0:
		Interacted = 1
		
		# Add in New Cam
		var NewCam = Camera.new()
		add_child(NewCam)
		NewCam.set_fov(Settingsholder.PlayerFOV)
		
		# Position/Rotate it correctly
		var CamLoc = PlayerCam.global_transform.origin
		var GameLoc = $Position3D.global_transform.origin
		var CamRot = PlayerCam.global_transform.basis
		var CamFOV = Settingsholder.PlayerFOV
#		print(CamRot.x)
#		print(CamRot.y)
#		print(CamRot.z)
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


func _on_PlayerCamera_tween_completed(object, key):
	_ingame()

func _ingame():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
#	yield(get_tree(), "idle_frame")
#	yield(get_tree(), "idle_frame")
	Screen.material_override.albedo_texture = viewport.get_texture()
	Menu.isActive = true

func _exit_game():
	# Re-add GUI and Player
	pass
