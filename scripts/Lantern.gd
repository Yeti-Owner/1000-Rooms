extends Spatial

onready var timer := $StartTimer
onready var light := $OmniLight
var Triggered := false
var rate

func _ready():
	randomize()
	timer.wait_time = randi() % 4 + 1
	timer.start()
	var r1 := rand_range(0.0007, 0.005)
	var r2 := rand_range(0.0007, 0.005)
	rate = max(r1, r2)

func _physics_process(_delta):
	if Triggered:
		light.omni_range = max(0.23, light.omni_range - rate)

func _on_StartTimer_timeout():
	Triggered = true
	print(rate)
