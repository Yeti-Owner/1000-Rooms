extends Spatial

var mouse_sensitivity = float(Settingsholder.MouseSensitivity)/100
var light_speed := 15.0

onready var _camera := $Camera
onready var light := get_parent().get_node("Light")
onready var tween := get_parent().get_node("LightTween")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	tween.start()

func _input(event: InputEvent) -> void:
	mouse_sensitivity = float(Settingsholder.MouseSensitivity)/100
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_camera.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		_camera.rotation_degrees.x = clamp(_camera.rotation_degrees.x, -89.9, 89.9)

func _physics_process(_delta) -> void:
	tween.interpolate_property(light, "global_transform:basis", light.global_transform.basis, self.global_transform.basis, 0.1, tween.TRANS_LINEAR)
	tween.interpolate_property(light, "global_transform:basis", light.global_transform.basis, _camera.global_transform.basis, 0.1, tween.TRANS_LINEAR)
	
