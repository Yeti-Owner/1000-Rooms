extends Node

var file = File.new()
var save_settings = "user://Settings.dat"

# Saved Vars
var save_data = {
	"ShowFps" : 0,
	"MouseSensitivity" : 18,
	"PlayerFOV" : 70,
	"FrameRate" : 60,
	"BloomSet" : 0,
	"VsyncEnabled" : 0,
	"Brightness" : 3,
	"MasterVolume" : 25,
	"MusicVolume" : 50,
	"SfxVolume" : 50,
	"Intro" : 0,
	"Fullscreen" : 0,
	"FXAA" : 0,
	"MSAA" : 0,
	"ResolutionText" : "1080p",
	"ResolutionScale" : 6
}

# Signals
# warning-ignore:unused_signal
signal brightness_changed
# warning-ignore:unused_signal
signal bloom_changed
# warning-ignore:unused_signal
signal fps_changed
# warning-ignore:unused_signal
signal fov_changed
# warning-ignore:unused_signal
signal sens_changed

# Check saved data
func _ready():
	_load()

func _save():
	file.open(save_settings, File.WRITE)
	file.store_var(save_data)
	file.close()

func _load():
	if not file.file_exists(save_settings):
		_save()
	
	# Open save file and read values
	file.open(save_settings, File.READ)
	save_data = file.get_var()
	file.close()

func _default():
	save_data = {
	"ShowFps" : 0,
	"MouseSensitivity" : 18,
	"PlayerFOV" : 70,
	"FrameRate" : 60,
	"BloomSet" : 0,
	"VsyncEnabled" : 0,
	"Brightness" : 3,
	"MasterVolume" : 25,
	"MusicVolume" : 50,
	"SfxVolume" : 50,
	"Intro" : 0,
	"Fullscreen" : 0,
	"FXAA" : 0,
	"MSAA" : 0,
	"ResolutionText" : "1080p",
	"ResolutionScale" : 6
	}
	_save()
