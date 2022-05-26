extends CanvasLayer


func _ready():
	$RoomNumHolder/CenterContainer/RoomNum.set_text("Room: " + str(Settingsholder.RoomNum))

func _process(_delta):
	$MarginContainer/FpsCounter.text = str("Fps: " + str(Performance.get_monitor(Performance.TIME_FPS)))
	
	if Settingsholder.ShowFps:
		$MarginContainer.set_visible(true)
	else:
		$MarginContainer.set_visible(false)
