extends Popup
var VsyncEnabled = 0

# Below is Video tab
# code not made: ShowFps, Bloom, Brightness
func _ready():
	Engine.set_target_fps(int(Settingsholder.FrameRate))

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
	Settingsholder.FrameRate = MaxFps
	Engine.set_target_fps(int(Settingsholder.FrameRate))

# Show Fps
func _on_ShowFpsCheckBtn_pressed():
	Settingsholder.ShowFps = !Settingsholder.ShowFps

# Below is Audio Tab
# Nothing is added lmao

# placeholder


# Below is Gameplay Tab
# Nothing is added here either lmao

# Sensitivity
func _on_MouseSensitivitySlider_value_changed(Sensitivity):
	$SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer2/MouseSensitivityVal.set_text(str(Sensitivity))
	Settingsholder.MouseSensitivity = Sensitivity

# Fov
func _on_FovSlider_value_changed(CurrentFov):
	$SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovVal.set_text(str(CurrentFov))
	Settingsholder.PlayerFOV = CurrentFov


func _on_BloomCheckBtn_pressed():
	Settingsholder.BloomSet = !Settingsholder.BloomSet
	print(Settingsholder.BloomSet)
