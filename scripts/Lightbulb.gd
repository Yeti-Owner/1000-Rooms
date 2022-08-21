extends Spatial

export(bool) var Bulb_On
export(bool) var Flashing

var timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if not Bulb_On:
		$OmniLight.queue_free()
		$OnBulb.visible = false
		$OffBulb.visible = true
		$Sparks.queue_free()
	elif Flashing:
		timer = Timer.new()
		timer.wait_time = rand_range(0.05, 0.1)
		timer.connect("timeout", self, "_on_timer_timeout")
		add_child(timer)
		timer.start()
		$AudioStreamPlayer3D.play()
	elif not Flashing:
		$Sparks.queue_free()

func _on_timer_timeout():
	timer.wait_time = rand_range(0.05, 0.1)
	$OmniLight.light_energy = rand_range(0, 2.0)
