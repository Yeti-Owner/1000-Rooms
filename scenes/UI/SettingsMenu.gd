extends Popup

# Below is Video tab
# code not made: Bloom, Brightness
func _ready():
	$SettingsTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsValue.set_text(str(Settingsholder.FrameRate))
	$SettingsTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsSlider.set_value(Settingsholder.FrameRate)
	Engine.set_target_fps(int(Settingsholder.FrameRate))
	$SettingsTabs/Video/MarginContainer/VideoSettings/VsyncCheckBtn.set_pressed_no_signal(Settingsholder.VsyncEnabled)
	$SettingsTabs/Video/MarginContainer/VideoSettings/ShowFpsCheckBtn.set_pressed_no_signal(Settingsholder.ShowFps)
	$SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovVal.set_text(str(Settingsholder.PlayerFOV))
	$SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovSlider.set_value(Settingsholder.PlayerFOV)
	$SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer2/MouseSensitivityVal.set_text(str(Settingsholder.MouseSensitivity))
	$SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer2/MouseSensitivitySlider.set_value(Settingsholder.MouseSensitivity)

# Windowed/Fullscreen option
func _on_DisplayOptionBtn_item_selected(FullScreenIndex):
	match FullScreenIndex:
		0:
			OS.set_window_fullscreen(false)
		1:
			OS.set_window_fullscreen(true)

# Vsync
func _on_VsyncCheckBtn_pressed():
	Settingsholder.VsyncEnabled = !Settingsholder.VsyncEnabled
	OS.set_use_vsync(Settingsholder.VsyncEnabled)

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
	Settingsholder.PlayerFOV = CurrentFov
	$SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovVal.set_text(str(CurrentFov))


func _on_BloomCheckBtn_pressed():
	Settingsholder.BloomSet = !Settingsholder.BloomSet
