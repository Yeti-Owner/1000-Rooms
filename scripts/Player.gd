extends KinematicBody

var walk_speed: float = 6.0
var jump_speed: float = 8.9
var acceleration_speed: float = 6.5
var gravity: float = -32.0
var _dir = Vector3.ZERO
var _vel = Vector3.ZERO
var EnabledWalking = 1
var sprinting = false
var FootStepList = ["res://assets/audio/misc/footsteps/wood_floor1.wav","res://assets/audio/misc/footsteps/tiles1.wav","res://assets/audio/misc/footsteps/hub_floor.wav","res://assets/audio/misc/footsteps/shop_floor.wav"]
var Area2 := ""

# References
onready var _camera := $CameraHolder
onready var Stamina = get_parent().get_node("GUI/HPandStam/StamBar2")
onready var StepPlayer = $StepPlayer
onready var Health = get_parent().get_node("GUI/HPandStam/HpBar2")
onready var PlayerAnim = $PlayerAnims
onready var HurtAnims = $HurtPlayer

func _ready():
	if SaveGame.game_data.PlayerHP > 100:
		SaveGame.game_data.PlayerHP = 100


func _physics_process(delta: float):
	var input = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		input.y += 1
	if Input.is_action_pressed("down"):
		input.y -= 1
	if Input.is_action_pressed("right"):
		input.x += 1
	if Input.is_action_pressed("left"):
		input.x -= 1
	if Input.is_action_just_pressed("sprint"): # when you first sprint it takes more
		Stamina.set_value(Stamina.get_value() - 7.5)
	if Input.is_action_pressed("sprint") && Stamina.get_value() > 0 && EnabledWalking :
		walk_speed = 7.5
		Stamina.set_value(Stamina.get_value() - 0.2)
		sprinting = true
	elif EnabledWalking: # When _die() is triggered walking is disabled here, dunno a better way to do it but I'm sure there is
		walk_speed = 6.0
		sprinting = false
	input = input.normalized()
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump") && Stamina.get_value() > 10:
			Stamina.set_value(Stamina.get_value() - 10)
		if Input.is_action_pressed("jump") && Stamina.get_value() > 10:
			_vel.y = jump_speed
	
	_vel.y += gravity * delta
	
	var basis: Basis = _camera.global_transform.basis
	_dir = Vector3.ZERO
	_dir += -basis.z * input.y
	_dir += basis.x * input.x
	_dir = _dir.normalized()
	
	var acc = _vel.linear_interpolate(_dir * walk_speed, acceleration_speed * delta)
	_vel = move_and_slide(Vector3(acc.x, _vel.y, acc.z), Vector3.UP)
	
	# If moving play head bob animation
	if _dir != Vector3() && EnabledWalking && sprinting:
		PlayerAnim.playback_speed = 1.25
		PlayerAnim.play("Head Bob")
	elif _dir != Vector3() && EnabledWalking:
		PlayerAnim.play("Head Bob")
		PlayerAnim.playback_speed = 1
	
	
	# Fix FOV
	$CameraHolder/Camera.set_fov(Settingsholder.PlayerFOV)
	
	if (Health.value <= 0):
		_die()


func _on_PlayerArea_area_entered(area):
	Area2 = area.name.rstrip("0123456789")
	if area.name == "GhostArea":
		_hurt("ghost")
	elif area.name == "FairyArea":
		_hurt("fairy")
	elif area.name == "SpikeArea":
		_hurt("spike")
	elif area.is_in_group("KillBox"):
		_die()
	elif area.is_in_group("ResetBox"):
		var _error = get_tree().reload_current_scene()
		SaveGame.game_data.PlayerHP -= 5
	elif Area2 == "WoodStepOne":
		StepPlayer.stream = load(FootStepList[0])
	elif Area2 == "TileStepOne":
		StepPlayer.stream = load(FootStepList[1])
	elif Area2 == "HubStep":
		StepPlayer.stream = load(FootStepList[2])
	elif Area2 == "ShopStep":
		StepPlayer.stream = load(FootStepList[3])
	elif Area2 == "AcidArea":
		EnabledWalking = 0
		jump_speed = 0
		walk_speed = 0
		PlayerAnim.play("acid_death", -2.0)
		print("Acid")


func _die():
	EnabledWalking = 0
	PlayerAnim.play("die")
	jump_speed = 0
	walk_speed = 0
	SaveGame.game_data.Deaths += 1

func _hurt(source):
	match source:
		"ghost":
			SaveGame.game_data.PlayerHP -= 15
			HurtAnims.play("hurt")
			$CameraHolder/Camera/HurtPlayer.play()
		"fairy":
			HurtAnims.play("hurt")
			SaveGame.game_data.PlayerHP -= 20
		"spike":
			HurtAnims.play("hurt")
			SaveGame.game_data.PlayerHP -= 10

func _on_PlayerAnims_animation_finished(anim_name):
	if anim_name == "die":
		SaveGame.game_data.PlayerHP = 100
		SaveGame.game_data.RoomNum = SaveGame.game_data.LastSavedRoom
		var _error = get_tree().change_scene(SaveGame.game_data.LastCheckPoint)
