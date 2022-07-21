extends Popup


# Cleaned up referencing
onready var MaxFpsValue = $SettingsTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsValue
onready var MaxFpsSlider = $SettingsTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsSlider
onready var VsyncCheckBtn = $SettingsTabs/Video/MarginContainer/VideoSettings/VsyncCheckBtn
onready var ShowFpsCheckBtn = $SettingsTabs/Video/MarginContainer/VideoSettings/ShowFpsCheckBtn
onready var FovVal = $SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovVal
onready var FovSlider = $SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovSlider
onready var MouseSensitivityVal = $SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer2/MouseSensitivityVal
onready var MouseSensitivitySlider = $SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer2/MouseSensitivitySlider
onready var BloomCheckBtn = $SettingsTabs/Video/MarginContainer/VideoSettings/BloomCheckBtn
onready var BrightnessSlider = $SettingsTabs/Video/MarginContainer/VideoSettings/BrightnessSlider
onready var MasterVol = $SettingsTabs/Audio/MarginContainer/AudioSettings/MasterVolSlider
onready var MusicVol = $SettingsTabs/Audio/MarginContainer/AudioSettings/MusicVolSlider
onready var SfxVol = $SettingsTabs/Audio/MarginContainer/AudioSettings/SfxVolSlider
onready var ClickPlayer = $ClickPlayer

func _ready():
	# Set FPS to correct value
	Engine.set_target_fps(int(Settingsholder.FrameRate))
	
	# Set values and sliders to correct value
	MaxFpsValue.set_text(str(Settingsholder.FrameRate))
	MaxFpsSlider.set_value(Settingsholder.FrameRate)
	VsyncCheckBtn.set_pressed_no_signal(Settingsholder.VsyncEnabled)
	ShowFpsCheckBtn.set_pressed_no_signal(Settingsholder.ShowFps)
	FovVal.set_text(str(Settingsholder.PlayerFOV))
	FovSlider.set_value(Settingsholder.PlayerFOV)
	MouseSensitivityVal.set_text(str(Settingsholder.MouseSensitivity))
	MouseSensitivitySlider.set_value(Settingsholder.MouseSensitivity)
	BloomCheckBtn.set_pressed_no_signal(Settingsholder.BloomSet)
	BrightnessSlider.set_value(Settingsholder.Brightness)
	MasterVol.set_value(Settingsholder.MasterVolume)
	MusicVol.set_value(Settingsholder.MusicVolume)
	SfxVol.set_value(Settingsholder.SfxVolume)

# Windowed/Fullscreen option
func _on_DisplayOptionBtn_item_selected(FullScreenIndex):
	match FullScreenIndex:
		0:
			OS.set_window_fullscreen(false)
			ClickPlayer._click_sound()
		1:
			OS.set_window_fullscreen(true)
			ClickPlayer._click_sound()

# Vsync
func _on_VsyncCheckBtn_pressed():
	Settingsholder.VsyncEnabled = !Settingsholder.VsyncEnabled
	OS.set_use_vsync(Settingsholder.VsyncEnabled)
	ClickPlayer._click_sound()

# Max Fps
func _on_MaxFpsSlider_value_changed(MaxFps):
	MaxFpsValue.set_text(str(MaxFps))
	Settingsholder.FrameRate = MaxFps
	Engine.set_target_fps(int(Settingsholder.FrameRate))

# Show Fps
func _on_ShowFpsCheckBtn_pressed():
	Settingsholder.ShowFps = !Settingsholder.ShowFps
	ClickPlayer._click_sound()

# Sensitivity
func _on_MouseSensitivitySlider_value_changed(Sensitivity):
	MouseSensitivityVal.set_text(str(Sensitivity))
	Settingsholder.MouseSensitivity = Sensitivity

# Fov
func _on_FovSlider_value_changed(CurrentFov):
	Settingsholder.PlayerFOV = CurrentFov
	FovVal.set_text(str(CurrentFov))

# Enable/Disable Bloom
func _on_BloomCheckBtn_pressed():
	Settingsholder.BloomSet = !Settingsholder.BloomSet
	Settingsholder.emit_signal("bloom_changed")
	ClickPlayer._click_sound()

# Adjust Brightness
func _on_BrightnessSlider_value_changed(CurrentBrightness):
	Settingsholder.Brightness = CurrentBrightness
	Settingsholder.emit_signal("brightness_changed")

# Master Volume
func _on_MasterVolSlider_value_changed(MasVol):
	Settingsholder.MasterVolume = MasVol
	MasVol = MasVol - 40
	AudioServer.set_bus_volume_db(0, MasVol)

# Music Volume
func _on_MusicVolSlider_value_changed(MusVol):
	Settingsholder.MusicVolume = MusVol
	MusVol = MusVol - 50
	AudioServer.set_bus_volume_db(1, MusVol)

# Sound Effects/Sfx Volume
func _on_SfxVolSlider_value_changed(SfVol):
	Settingsholder.SfxVolume = SfVol
	SfVol = SfVol - 50
	AudioServer.set_bus_volume_db(2, SfVol)

func _on_SettingsTabs_tab_changed(_tab):
	ClickPlayer._click_sound()
