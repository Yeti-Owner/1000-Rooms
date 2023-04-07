extends Node

const save_settings := "user://Settings.dat"
const save_keybinds := "user://Keybinds.dat"

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
signal brightness_changed
signal bloom_changed
signal fps_changed
signal fov_changed
signal sens_changed
signal quality_bloom_changed
signal hp_changed

# Check saved data
func _ready():
	if not FileAccess.file_exists(save_settings):
		_save(save_settings, save_data)
	else:
		save_data = _load(save_settings)
	if not FileAccess.file_exists(save_keybinds):
		_save(save_keybinds, keybinds_data)
	else:
		keybinds_data = _load(save_keybinds)

func _save(SaveType:String, SaveData):
	# Save data based off given file path and data
	var file := FileAccess.open(SaveType, FileAccess.WRITE)
	file.store_var(SaveData)

func _load(LoadType:String):
	# Open save file and read values
	var file := FileAccess.open(LoadType, FileAccess.READ)
	return file.get_var()

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
	_save(save_settings, save_data)

func _apply_keybinds():
	var binds = ["up","down","left","right","jump","sprint","interact","console","pause"]
	for bind in binds:
		var event := InputEventKey.new()
		event.keycode = keybinds_data[bind]
		InputMap.action_erase_events(bind)
		InputMap.action_add_event(bind, event)
