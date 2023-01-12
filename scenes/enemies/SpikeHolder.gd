extends PathFollow

var Chase := true
onready var path := get_parent()

func _ready():
	randomize()
	$Timer.wait_time = randi() % 5 + 1
	$Timer.start()

func _process(_delta):
	if Chase == true:
		var targetGlobalPosition: Vector3 = get_node("/root/world/Fader/Player").global_transform.origin
		var closestOffset = path.curve.get_closest_offset(path.to_local(targetGlobalPosition))
		self.offset = closestOffset
	else:
		return


func _on_Timer_timeout():
	$SpikeHolder._triggered()
