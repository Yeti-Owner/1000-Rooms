extends KinematicBody
var walk_speed = 6.0
var jump_speed = 8.9
var acceleration_speed = 6.5
var gravity = -32.0
var _dir = Vector3.ZERO
var _vel = Vector3.ZERO
var EnabledWalking = 1

# References
onready var _camera := $CameraHolder
onready var anim_player = $CameraHolder/Camera/AnimationPlayer
onready var Stamina = get_parent().get_node("GUI/HPandStam/HBoxContainer2/StamBar")
onready var StepPlayer = $StepPlayer
onready var Health = get_parent().get_node("GUI/HPandStam/HBoxContainer/HpBar")
onready var PlayerAnim = $PlayerAnims

func _physics_process(delta: float) -> void:
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
		$Timer.set_wait_time(0.3)
	elif EnabledWalking: # When _die() is triggered walking is disabled here, dunno a better way to do it but I'm sure there is
		walk_speed = 6.0
		$Timer.set_wait_time(0.5)
	input = input.normalized()
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump") && Stamina.get_value() > 10:
			Stamina.set_value(Stamina.get_value() - 10)
		if Input.is_action_pressed("jump") && Stamina.get_value() > 10:
			_vel.y = jump_speed
	else: # footstep timer
		$Timer.stop()
	
	_vel.y += gravity * delta
	
	var basis: Basis = _camera.global_transform.basis
	_dir = Vector3.ZERO
	_dir += -basis.z * input.y
	_dir += basis.x * input.x
	_dir = _dir.normalized()
	
	var acc = _vel.linear_interpolate(_dir * walk_speed, acceleration_speed * delta)
	_vel = move_and_slide(Vector3(acc.x, _vel.y, acc.z), Vector3.UP)
	
	# If moving play head bob animation
	if _dir != Vector3() && EnabledWalking:
		anim_player.play("Head Bob")
		if $Timer.is_stopped():
			$Timer.start()
	
	# Fix FOV
	$CameraHolder/Camera.set_fov(Settingsholder.PlayerFOV)
	
	if (Health.value <= 0):
		_die()

func _on_Timer_timeout():
	if EnabledWalking:
		StepPlayer.pitch_scale = rand_range(0.85, 1.15)
		StepPlayer.play()


func _on_PlayerArea_area_entered(PlayerArea):
	if PlayerArea.name == "EnemyArea":
		PlayerAnim.play("hurt")
		$CameraHolder/Camera/HurtPlayer.play()
		SaveGame.game_data.PlayerHP -= 20
	elif PlayerArea.name == "KillBox":
		_die()
	elif PlayerArea.name == "ResetBox":
		var _error = get_tree().reload_current_scene()

func _die():
	EnabledWalking = 0
	PlayerAnim.play("die")
	jump_speed = 0
	walk_speed = 0

func _on_PlayerAnims_animation_finished(anim_name):
	if anim_name == "die":
		SaveGame.game_data.PlayerHP = 100
		SaveGame.game_data.RoomNum = SaveGame.game_data.LastSavedRoom
		var _error = get_tree().change_scene(SaveGame.game_data.LastCheckPoint)
