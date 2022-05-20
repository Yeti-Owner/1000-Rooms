extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$FpsCounter.text = str(Performance.get_monitor(Performance.TIME_FPS))
