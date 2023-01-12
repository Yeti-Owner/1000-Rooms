extends AudioStreamPlayer

var transitionstage := 0
var OldMusVol

func _ready():
	OldMusVol = Settingsholder.save_data.MusicVolume*0.05

func _music_transition():
	if transitionstage < 10:
		$TransitionTimer.start()
	else:
		Settingsholder.save_data.MusicVolume = OldMusVol*20
		AudioServer.set_bus_volume_db(1, Settingsholder.save_data.MusicVolume-50)

func _on_TransitionTimer_timeout():
	Settingsholder.save_data.MusicVolume = Settingsholder.save_data.MusicVolume - OldMusVol
	transitionstage += 1
	AudioServer.set_bus_volume_db(1, Settingsholder.save_data.MusicVolume-50)
	_music_transition()
