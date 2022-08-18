extends Node

var file = File.new()
var save_settings = "user://settings.dat"


var ShowFps = 0
var MouseSensitivity = 18
var PlayerFOV = 70
var FrameRate = 60
var BloomSet = 0
var VsyncEnabled = 0
var Brightness = 3
var MasterVolume = 25
var MusicVolume = 50
var SfxVolume = 50
var Intro = 0
var Fullscreen = 0

# Signals
# warning-ignore:unused_signal
signal brightness_changed
# warning-ignore:unused_signal
signal bloom_changed
# warning-ignore:unused_signal
signal fps_changed

# Check saved data
func _ready():
	# If save file doesnt exist put in default values
	if not file.file_exists(save_settings):
		_save()
	
	# Open save file and read values
	file.open(save_settings, File.READ)
	ShowFps = file.get_8()
	MouseSensitivity = file.get_8()
	PlayerFOV = file.get_8()
	FrameRate = file.get_8()
	BloomSet = file.get_8()
	VsyncEnabled = file.get_8()
	Brightness = file.get_8()
	MasterVolume = file.get_8()
	MusicVolume = file.get_8()
	SfxVolume = file.get_8()
	Intro = file.get_8()
	Fullscreen = file.get_8()
	file.close()

func _save():
	file.open(save_settings, File.WRITE)
	file.store_buffer([ShowFps, MouseSensitivity, PlayerFOV, FrameRate, BloomSet, VsyncEnabled, Brightness, MasterVolume, MusicVolume, SfxVolume, Intro, Fullscreen])
	file.close()

func _default():
	ShowFps = 0
	MouseSensitivity = 18
	PlayerFOV = 70
	FrameRate = 60
	BloomSet = 0
	VsyncEnabled = 0
	Brightness = 3
	MasterVolume = 25
	MusicVolume = 50
	SfxVolume = 50
	Intro = 0
	Fullscreen = 0
	_save()
