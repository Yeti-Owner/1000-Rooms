extends Spatial

onready var timer := $StartTimer
onready var light := $OmniLight
onready var LightArea := $LightArea/CollisionShape
export var Shrinks:bool = true

var Triggered := false
var rate:float

func _ready():
	randomize()
	if Shrinks:
		timer.wait_time = randi() % 10 + 5
		timer.start()
		var r1 := rand_range(0.00025, 0.003)
		var r2 := rand_range(0.00025, 0.003)
		rate = min(r1, r2)

func _physics_process(_delta):
	if Triggered:
		light.omni_range = max(0.23, light.omni_range - rate)
		LightArea.shape.radius = max(0.01, light.omni_range - rate)
		if LightArea.shape.radius == 0.01:
			$LanternSound.queue_free()
			$LightArea.queue_free()

func _on_StartTimer_timeout():
	Triggered = true
