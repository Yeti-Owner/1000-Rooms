extends KinematicBody

var walk_speed: float = 6.0
var sprint_speed: float = 7.5
var jump_speed: float = 8.9
var acceleration_speed: float = 6.0
var gravity: float = -32.0
var _dir = Vector3.ZERO
var _vel = Vector3.ZERO
#var EnabledWalking = 1
#var sprinting = false
var FootStepList = ["res://assets/audio/misc/footsteps/wood_floor1.wav","res://assets/audio/misc/footsteps/tiles1.wav","res://assets/audio/misc/footsteps/hub_floor.wav","res://assets/audio/misc/footsteps/shop_floor.wav"]

# States
enum {
	DEAD,
	WALKING,
	RUNNING
}
var state = WALKING

onready var _camera := get_node("%CameraHolder")
onready var Stamina = get_node("/root/SceneManager/GameScene/HUD/GUI/HPandStam/StamBar2")
onready var StepPlayer = $StepPlayer
onready var Health = get_node("/root/SceneManager/GameScene/HUD/GUI/HPandStam/HpBar2")
onready var PlayerAnim = $PlayerAnims
onready var HurtAnims = $HurtPlayer
onready var Coyote = $CoyoteTimer

func _ready():
	if SaveGame.game_data.PlayerHP > 100:
		SaveGame.game_data.PlayerHP = 100
# warning-ignore:return_value_discarded
	Settingsholder.connect("fov_changed", self, "_update_fov")

func _physics_process(delta: float):
	# Set State
	if Input.is_action_just_pressed("sprint"):
		Stamina.set_value(Stamina.get_value() - 7.5)
		state = RUNNING
	if Input.is_action_pressed("sprint") && Stamina.get_value() > 0:
		Stamina.set_value(Stamina.get_value() - 0.2)
		state = RUNNING
	if state != DEAD and not Input.is_action_pressed("sprint"):
		state = WALKING
	if (Health.value <= 0):
		_die()
	
	# Use State
	match state:
		DEAD:
			pass
		WALKING:
			_movement(delta, walk_speed, 1)
		RUNNING:
			_movement(delta, sprint_speed, 1.25)
	
	# Check HP
	if (Health.value <= 0):
		_die()


func _movement(delta, UsedSpeed, bob_speed):
	var input = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		input.y += 1
	if Input.is_action_pressed("down"):
		input.y -= 1
	if Input.is_action_pressed("right"):
		input.x += 1
	if Input.is_action_pressed("left"):
		input.x -= 1
	input = input.normalized()
	
	
	# Jumping
	if _vel.y <= 0 && (is_on_floor() || !Coyote.is_stopped()):
		if Input.is_action_just_pressed("jump") && Stamina.get_value() > 10:
			Coyote.stop()
			Stamina.set_value(Stamina.get_value() - 10)
			_vel.y = jump_speed
	
	
	_vel.y += gravity * delta
	
	var basis: Basis = _camera.global_transform.basis
	_dir = Vector3.ZERO
	_dir += -basis.z * input.y
	_dir += basis.x * input.x
	_dir = _dir.normalized()
	
	
	var acc = _vel.linear_interpolate(_dir * UsedSpeed, acceleration_speed * delta)
	
	var was_on_floor = is_on_floor()
	
	_vel = move_and_slide(Vector3(acc.x, _vel.y, acc.z), Vector3.UP)
	
	if was_on_floor && !is_on_floor():
		Coyote.start()
	
	# If moving play head bob animation
	if _dir != Vector3():
		PlayerAnim.playback_speed = bob_speed
		PlayerAnim.play("Head Bob")

func _on_PlayerArea_area_entered(area):
	var Area2 = area.name.rstrip("0123456789")
	match Area2:
		"GhostArea":
			_hurt("ghost")
		"FairyArea":
			_hurt("fairy")
		"SpikeArea":
			_hurt("spike")
		"WoodStepOne":
			StepPlayer.stream = load(FootStepList[0])
		"TileStepOne":
			StepPlayer.stream = load(FootStepList[1])
		"HubStep":
			StepPlayer.stream = load(FootStepList[2])
		"ShopStep":
			StepPlayer.stream = load(FootStepList[3])
		"AcidArea":
			state = DEAD
			PlayerAnim.play("acid_death", -2.0)
			print("Acid")

func _die():
	state = DEAD
	PlayerAnim.play("die")
	SaveGame.game_data.Deaths += 1

func _hurt(source):
	match source:
		"ghost":
			SaveGame.game_data.PlayerHP -= 15
			HurtAnims.play("hurt")
			$CameraHolder/Camera/HurtPlayer.play()
		"fairy":
			HurtAnims.play("hurt")
			SaveGame.game_data.PlayerHP -= 8
		"spike":
			HurtAnims.play("hurt")
			SaveGame.game_data.PlayerHP -= 10

func _on_PlayerAnims_animation_finished(anim_name):
	if anim_name == "die":
		SaveGame.game_data.PlayerHP = 100
		SaveGame.game_data.RoomNum = SaveGame.game_data.LastSavedRoom
		var _error = get_tree().change_scene(SaveGame.game_data.LastCheckPoint)

func _update_fov():
	$CameraHolder/Camera.set_fov(Settingsholder.save_data.PlayerFOV)
