extends CharacterBody3D

@onready var _camera := get_node("%CameraHolder")
@onready var Stamina := get_node("/root/SceneManager/GameScene/HUD/GUI/HPandStam/StamBar2")
@onready var StepPlayer := $StepPlayer
@onready var PlayerAnim := $PlayerAnims
@onready var HurtAnims := $HurtPlayer
@onready var Coyote := $CoyoteTimer
@onready var Hurtbox := $PlayerArea

var walk_speed: float = 6.0
var sprint_speed: float = 7.5
var jump_speed: float = 8.9
var acceleration_speed: float = 6.0
var gravity: float = -32.0
var _dir := Vector3.ZERO
var _vel := Vector3.ZERO
var isDead:bool = false
var FootStepList := ["res://assets/audio/misc/footsteps/wood_floor1.wav","res://assets/audio/misc/footsteps/tiles1.wav","res://assets/audio/misc/footsteps/hub_floor.wav","res://assets/audio/misc/footsteps/shop_floor.wav","res://assets/audio/misc/footsteps/MetalStep.wav"]
var iframes := false

# States
enum {
	DEAD,
	WALKING,
	RUNNING
}
var state := WALKING

func _ready():
	isDead = false
#	self.scale = Vector3(0.6, 0.6, 0.6)
	
	StepPlayer.stream = load(FootStepList[SaveGame.game_data.StepUsed])
	
	if SaveGame.game_data.PlayerHP > 100:
		SaveGame.game_data.PlayerHP = 100
# warning-ignore:return_value_discarded
	Settingsholder.connect("fov_changed",Callable(self,"_update_fov"))

func _physics_process(delta: float):
	# Set State
	if (SaveGame.game_data.PlayerHP <= 1) and (isDead == false):
		_die()
		state = DEAD
	
	if Input.is_action_just_pressed("sprint"):
		Stamina.set_value(Stamina.get_value() - 7.5)
		state = RUNNING
	if Input.is_action_pressed("sprint") && Stamina.get_value() > 0:
		Stamina.set_value(Stamina.get_value() - 0.2)
		state = RUNNING
	if (state != DEAD) and ((!Input.is_action_pressed("sprint") or Stamina.get_value() <= 2)):
		state = WALKING
		if Stamina.get_value() <= 5:
			$BreathingPlayer.play()
	
	# Use State
	match state:
		DEAD:
			pass
		WALKING:
			_movement(delta, walk_speed, 1)
		RUNNING:
			_movement(delta, sprint_speed, 1.25)

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
	
	var _basis: Basis = _camera.global_transform.basis
	_dir = Vector3.ZERO
	_dir += -_basis.z * input.y
	_dir += _basis.x * input.x
	_dir = _dir.normalized()
	
	
	var acc := _vel.lerp(_dir * UsedSpeed, acceleration_speed * delta)
	
	var was_on_floor := is_on_floor()
	
	set_velocity(Vector3(acc.x, _vel.y, acc.z))
	set_up_direction(Vector3.UP)
	move_and_slide()
	_vel = velocity
	
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
		"StatueArea":
			if area.get_parent().IsStunned == false:
				_hurt("statue")
				area.get_parent()._stun()
		"WoodStepOne":
			StepPlayer.stream = load(FootStepList[0])
			SaveGame.game_data.StepUsed = 0
		"TileStepOne":
			StepPlayer.stream = load(FootStepList[1])
			SaveGame.game_data.StepUsed = 1
		"HubStep":
			StepPlayer.stream = load(FootStepList[2])
			SaveGame.game_data.StepUsed = 2
		"ShopStep":
			StepPlayer.stream = load(FootStepList[3])
			SaveGame.game_data.StepUsed = 3
		"MetalStep":
			StepPlayer.stream = load(FootStepList[4])
			SaveGame.game_data.StepUsed = 4
		"AcidArea":
			state = DEAD
			PlayerAnim.play("acid_death", -2.0)
			print("Acid")

func _die():
	SaveGame.game_data.Deaths += 1
	isDead = true
	PlayerAnim.play("die")

func _hurt(source):
	if iframes == false:
		match source:
			"ghost":
				SaveGame.game_data.PlayerHP -= 15
				HurtAnims.play("hurt")
				$CameraHolder/Camera3D/HurtPlayer.play()
				SaveGame.DeathReason = "ghost"
				Settingsholder.emit_signal("hp_changed")
			"fairy":
				HurtAnims.play("hurt")
				SaveGame.game_data.PlayerHP -= 8
				SaveGame.DeathReason = "fairy"
				Settingsholder.emit_signal("hp_changed")
			"spike":
				HurtAnims.play("hurt")
				SaveGame.game_data.PlayerHP -= 10
				Settingsholder.emit_signal("hp_changed")
			"statue":
				HurtAnims.play("hurt")
				SaveGame.DeathReason = "statue"
				SaveGame.game_data.PlayerHP -= 24
				Settingsholder.emit_signal("hp_changed")
		iframes = true
		$iFrames.start()

func _on_PlayerAnims_animation_finished(anim_name):
	if anim_name == "die":
		SaveGame.game_data.PlayerHP = 100
		SaveGame.game_data.RoomNum = SaveGame.game_data.LastSavedRoom
		SceneManager._init_HUD("deathscreen")

func _update_fov():
	$CameraHolder/Camera3D.set_fov(Settingsholder.save_data.PlayerFOV)

func _on_iFrames_timeout():
	iframes = false
	for area in Hurtbox.get_overlapping_areas():
		if str(area.get_name()) == "GhostArea":
			_hurt("ghost")
			break
