extends Node3D

@export var Bulb_On: bool
@export var Flashing: bool

var timer:Timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if not Bulb_On:
		$OmniLight3D.queue_free()
		$OnBulb.visible = false
		$OffBulb.visible = true
		$Sparks.queue_free()
	elif Flashing:
		timer = Timer.new()
		timer.wait_time = randf_range(0.05, 0.1)
# warning-ignore:return_value_discarded
		timer.connect("timeout",Callable(self,"_on_timer_timeout"))
		add_child(timer)
		timer.start()
		$AudioStreamPlayer3D.play()
	elif not Flashing:
		$Sparks.queue_free()

func _on_timer_timeout():
	timer.wait_time = randf_range(0.05, 0.1)
	$OmniLight3D.light_energy = randf_range(0, 2.0)
