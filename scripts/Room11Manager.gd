extends Spatial

onready var Switch := $SwitchTimer


func _ready():
	randomize()
	Switch.wait_time = rand_range(0.5, 1)
	Switch.start()

func _on_SwitchTimer_timeout():
	_swap_visible()
	Switch.wait_time = rand_range(0.5, 1)
	Switch.start()

func _swap_visible():
	var RNG = randi() % 3 + 1
	
	# make all invisible
	for i in 3:
		i = i + 1
		get_node(str("GridMap" + str(i))).visible = false
	
	# make 1 visible
	get_node(str("GridMap" + str(RNG))).visible = true 
