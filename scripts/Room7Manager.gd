extends Spatial

onready var Sensor2 := $Sensor2
onready var Sensor3 := $Sensor3
onready var Player := get_parent().get_node("RoomItems/Player")

func _ready():
	Sensor2.global_transform.origin = Vector3(10, 1.9, 16.7)

func _on_Sensor_PlayerDetected():
	Sensor2.global_transform.origin = Vector3(0, 1.9, 16.7)

func _on_Sensor3_PlayerDetected():
	Player.global_transform.origin.z -= 10

func _on_Sensor2_PlayerDetected():
	Sensor3.queue_free()
