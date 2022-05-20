extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MarginContainer/FpsCounter.text = str("Fps: " + str(Performance.get_monitor(Performance.TIME_FPS)))
