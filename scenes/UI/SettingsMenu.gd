extends Popup
var VsyncEnabled = 0

# Below is Video tab
# code not made: ShowFps, Bloom, Brightness

# Windowed/Fullscreen option
func _on_DisplayOptionBtn_item_selected(FullScreenIndex):
	match FullScreenIndex:
		0:
			OS.set_window_fullscreen(false)
		1:
			OS.set_window_fullscreen(true)

# Vsync
func _on_VsyncCheckBtn_pressed():
	VsyncEnabled = !VsyncEnabled
	OS.set_use_vsync(VsyncEnabled)

# Max Fps
func _on_MaxFpsSlider_value_changed(MaxFps):
	$SettingsTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsValue.set_text(str(MaxFps))
	Engine.set_target_fps(int(MaxFps))


# Below is Audio Tab
# Nothing is added lmao

# placeholder


# Below is Gameplay Tab
# Nothing is added here either lmao
