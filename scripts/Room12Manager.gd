extends Spatial

onready var EnemySpawner := get_parent().get_node("NavMesh/EnemySpawner")
onready var Player := get_parent().get_node("RoomItems/Player")

func _on_Sensor_PlayerDetected():
	# Spawn Ghost
	EnemySpawner._summon()

func _on_Sensor2_PlayerDetected():
	# move player
	Player.global_transform.origin.x += 44
