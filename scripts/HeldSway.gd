extends Spatial

var mouse_mov
var sway_threshold := 5
var sway_lerp := 5

export var sway_left : Vector3
export var sway_right : Vector3
export var sway_normal : Vector3

func _input(event):
	if event is InputEventMouseMotion:
		mouse_mov = -event.relative.x

func _process(delta):
	if mouse_mov != null:
		if mouse_mov > sway_threshold:
			rotation = rotation.linear_interpolate(sway_left, sway_lerp * delta)
		elif mouse_mov < -sway_threshold:
			rotation = rotation.linear_interpolate(sway_right, sway_lerp * delta)
		else:
			rotation = rotation.linear_interpolate(sway_normal, sway_lerp * delta)
