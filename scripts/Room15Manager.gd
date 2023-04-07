extends Node3D

@onready var Player := get_parent().get_node("RoomItems/Player")


func _on_Sensor_PlayerDetected():
	Player.global_transform.origin.x -= 65


func _on_Sensor2_PlayerDetected():
	Player.global_transform.origin.x += 65
