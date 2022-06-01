extends KinematicBody
var walk_speed := 6.0
var jump_speed := 8.5
var acceleration_speed := 6.5
var gravity := -32.0
var _dir := Vector3.ZERO
var _vel := Vector3.ZERO
var SubtractStam

# References
onready var _camera := $CameraHolder
onready var anim_player = $CameraHolder/Camera/AnimationPlayer
onready var Stamina = get_parent().get_node("GUI/HPandStam/HBoxContainer2/StamBar")
onready var StepPlayer = $StepPlayer


func _physics_process(delta: float) -> void:
	var input := Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		input.y += 1
	if Input.is_action_pressed("down"):
		input.y -= 1
	if Input.is_action_pressed("right"):
		input.x += 1
	if Input.is_action_pressed("left"):
		input.x -= 1
	if Input.is_action_just_pressed("sprint"):
		SubtractStam = Stamina.get_value()
		SubtractStam = SubtractStam - 7.5
		Stamina.set_value(SubtractStam)
	if Input.is_action_pressed("sprint") && Stamina.get_value() > 0:
		walk_speed = 7.5
		SubtractStam = Stamina.get_value()
		SubtractStam = SubtractStam - 0.3
		Stamina.set_value(SubtractStam)
		$Timer.set_wait_time(0.3)
	else:
		walk_speed = 6.0
		$Timer.set_wait_time(0.5)
	input = input.normalized()
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump") && Stamina.get_value() > 10:
			SubtractStam = Stamina.get_value()
			SubtractStam = SubtractStam - 10
			Stamina.set_value(SubtractStam)
			_vel.y = jump_speed
	else:
		$Timer.stop()
	
	_vel.y += gravity * delta
	
	var basis: Basis = _camera.global_transform.basis
	_dir = Vector3.ZERO
	_dir += -basis.z * input.y
	_dir += basis.x * input.x
	_dir = _dir.normalized()
	
	var acc := _vel.linear_interpolate(_dir * walk_speed, acceleration_speed * delta)
	_vel = move_and_slide(Vector3(acc.x, _vel.y, acc.z), Vector3.UP)
	
	if _dir != Vector3():
		anim_player.play("Head Bob")
		if $Timer.is_stopped():
			$Timer.start()
	
	# Fix FOV
	$CameraHolder/Camera.set_fov(Settingsholder.PlayerFOV)
	


func _on_Timer_timeout():
	StepPlayer.pitch_scale = rand_range(0.85, 1.15)
	StepPlayer.play()
