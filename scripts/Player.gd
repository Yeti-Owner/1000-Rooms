extends KinematicBody
var walk_speed := 6.0
var jump_speed := 10.0
var acceleration_speed := 6.5
var gravity := -32.0
var _dir := Vector3.ZERO
var _vel := Vector3.ZERO
onready var _camera := $CameraHolder


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
	
	input = input.normalized()
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			_vel.y = jump_speed
	
	_vel.y += gravity * delta
	
	var basis: Basis = _camera.global_transform.basis
	_dir = Vector3.ZERO
	_dir += -basis.z * input.y
	_dir += basis.x * input.x
	_dir = _dir.normalized()
	
	var acc := _vel.linear_interpolate(_dir * walk_speed, acceleration_speed * delta)
	_vel = move_and_slide(Vector3(acc.x, _vel.y, acc.z), Vector3.UP)






