extends Node

var file := File.new()
var file2 := File.new()
var save_settings := "user://Settings.dat"
var save_keybinds := "user://Keybinds.dat"

# Saved Vars
var save_data := {
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
	"Fullscreen" : 0,
	"FXAA" : 0,
	"MSAA" : 0,
	"ResolutionText" : "1080p",
	"ResolutionScale" : 6,
	"QualityBloom" : 0
}

var keybinds_data := {
	"up" : KEY_W,
	"down" : KEY_S,
	"left" : KEY_A,
	"right" : KEY_D,
	"jump" : KEY_SPACE,
	"sprint" : KEY_SHIFT,
	"interact" : KEY_E,
	"pause" : KEY_ESCAPE,
	"console" : KEY_QUOTELEFT
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
# warning-ignore:unused_signal
signal quality_bloom_changed

# Check saved data
func _ready():
	_load()

func _save():
	# Normal Settings
# warning-ignore:return_value_discarded
	file.open(save_settings, File.WRITE)
	file.store_var(save_data)
	file.close()
	
# warning-ignore:return_value_discarded
	file2.open(save_keybinds, File.WRITE)
	file2.store_var(keybinds_data)
	file2.close()

func _load():
	if not file.file_exists(save_settings):
		_save()
	if not file2.file_exists(save_keybinds):
		_save()
	
	# Open save file and read values
# warning-ignore:return_value_discarded
	file.open(save_settings, File.READ)
	save_data = file.get_var()
	file.close()
	
	# ^^^ but binds
# warning-ignore:return_value_discarded
	file2.open(save_keybinds, File.READ)
	keybinds_data = file2.get_var()
	file2.close()

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
	"Fullscreen" : 0,
	"FXAA" : 0,
	"MSAA" : 0,
	"ResolutionText" : "1080p",
	"ResolutionScale" : 6,
	"QualityBloom" : 0
	}
	_save()

func _apply_keybinds():
	var binds = ["up","down","left","right","jump","sprint","interact","console","pause"]
	for bind in binds:
		var event := InputEventKey.new()
		event.scancode = keybinds_data[bind]
		InputMap.action_erase_events(bind)
		InputMap.action_add_event(bind, event)
