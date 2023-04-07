extends Node3D

var mouse_sensitivity = float(Settingsholder.save_data.MouseSensitivity)/100
var light_speed := 15.0

@onready var _camera := $Camera3D
@onready var light := get_node("%Light3D")
@onready var tween := get_node("%LightTween")
@onready var LightCast := get_node("%LightCast")
@onready var LightCast2 := get_node("%LightCast2")
@onready var LightCast3 := get_node("%LightCast3")
@onready var LightMesh := get_node("%Flashlight")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
# warning-ignore:return_value_discarded
	Settingsholder.connect("sens_changed",Callable(self,"_update_sens"))
	$Camera3D.fov = Settingsholder.save_data.PlayerFOV

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		_camera.rotation_degrees.x = clamp(_camera.rotation_degrees.x, -89.9, 89.9)

func _physics_process(_delta) -> void:
	tween.interpolate_property(light, "global_transform:basis", light.global_transform.basis, self.global_transform.basis, 0.1, tween.TRANS_LINEAR)
	tween.interpolate_property(light, "global_transform:basis", light.global_transform.basis, _camera.global_transform.basis, 0.1, tween.TRANS_LINEAR)
	
	# Move Flashlight when raycasts hit wall/obj
	if LightCast.is_colliding():
		LightMesh.position.z = lerp(LightMesh.position.z, 0.45, 0.05)
	else:
		LightMesh.position.z = lerp(LightMesh.position.z, 0, 0.05)
	if LightCast2.is_colliding() or LightCast3.is_colliding():
		LightMesh.position.x = lerp(LightMesh.position.x, -0.22, 0.05)
	else:
		LightMesh.position.x = lerp(LightMesh.position.x, 0, 0.05)

func _on_Timer_timeout():
	tween.start()

func _update_sens():
	mouse_sensitivity = float(Settingsholder.save_data.MouseSensitivity)/100
