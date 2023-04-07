extends Node3D

@onready var Player := get_parent().get_node("RoomItems/Player")
var hits := 0

func _ready():
	for child in get_children():
		child.connect("PlayerDetected",Callable(self,"_player_hit"))

func _player_hit():
	hits += 1
	
	match hits:
		4:
			Player.global_transform.origin.z += 30
		8:
			Player.global_transform.origin.z += 30
		12:
			Player.global_transform.origin.z += 30
