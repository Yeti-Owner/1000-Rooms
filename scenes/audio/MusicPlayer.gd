extends AudioStreamPlayer

var MusicList = ["res://assets/audio/music/Victima1.ogg", "res://assets/audio/music/Victima2.ogg", "res://assets/audio/music/vgm-spacewalk.ogg"]
var transitionstage = 0
var OldMusVol

func _ready():
	OldMusVol = Settingsholder.MusicVolume*0.05
	SaveGame.connect("BeingChased", self, "_chase_music")
	randomize()
	_random_music()

func _on_MusicPlayer_finished():
	_random_music()

func _random_music():
	self.stream = load(MusicList [randi() % MusicList.size()])
	play()

func _chase_music():
	if SaveGame.isChased:
		match SaveGame.ChasedBy:
			0:
				self.stream = load("res://assets/audio/music/Chase1.ogg")
				play()
			1:
				_random_music()
	else:
		_music_transition()

func _music_transition():
	if transitionstage < 10:
		$TransitionTimer.start()
	else:
		Settingsholder.MusicVolume = OldMusVol*20
		AudioServer.set_bus_volume_db(1, Settingsholder.MusicVolume-50)
		_random_music()

func _on_TransitionTimer_timeout():
	Settingsholder.MusicVolume = Settingsholder.MusicVolume - OldMusVol
	transitionstage += 1
	AudioServer.set_bus_volume_db(1, Settingsholder.MusicVolume-50)
	_music_transition()
