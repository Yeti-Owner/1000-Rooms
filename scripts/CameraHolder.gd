extends Spatial

var mouse_sensitivity = float(Settingsholder.MouseSensitivity)/100

onready var _camera := $Camera

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	mouse_sensitivity = float(Settingsholder.MouseSensitivity)/100
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_camera.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		_camera.rotation_degrees.x = clamp(_camera.rotation_degrees.x, -89.9, 89.9)
