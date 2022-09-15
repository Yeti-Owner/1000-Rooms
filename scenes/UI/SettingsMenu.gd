extends Popup

# vars
var dir = Directory.new()
var save_data = "user://save_game.dat"

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
onready var FullScreenOption = $SettingsTabs/Video/MarginContainer/VideoSettings/DisplayOptionBtn

func _ready():
	# Set FPS to correct value
	Engine.set_target_fps(int(Settingsholder.save_data.FrameRate))
	
	# Set Windowd/Fullscreen
	OS.set_window_fullscreen(Settingsholder.save_data.Fullscreen)
	
	# Set values and sliders to correct value
	MaxFpsValue.set_text(str(Settingsholder.save_data.FrameRate))
	MaxFpsSlider.set_value(Settingsholder.save_data.FrameRate)
	VsyncCheckBtn.set_pressed_no_signal(Settingsholder.save_data.VsyncEnabled)
	ShowFpsCheckBtn.set_pressed_no_signal(Settingsholder.save_data.ShowFps)
	FovVal.set_text(str(Settingsholder.save_data.PlayerFOV))
	FovSlider.set_value(Settingsholder.save_data.PlayerFOV)
	MouseSensitivityVal.set_text(str(Settingsholder.save_data.MouseSensitivity))
	MouseSensitivitySlider.set_value(Settingsholder.save_data.MouseSensitivity)
	BloomCheckBtn.set_pressed_no_signal(Settingsholder.save_data.BloomSet)
	BrightnessSlider.set_value(Settingsholder.save_data.Brightness)
	MasterVol.set_value(Settingsholder.save_data.MasterVolume)
	MusicVol.set_value(Settingsholder.save_data.MusicVolume)
	SfxVol.set_value(Settingsholder.save_data.SfxVolume)
	FullScreenOption.selected = Settingsholder.save_data.Fullscreen

# Windowed/Fullscreen option
func _on_DisplayOptionBtn_item_selected(FullScreenIndex):
	match FullScreenIndex:
		0:
			OS.set_window_fullscreen(false)
			ClickPlayer._click_sound()
			Settingsholder.save_data.Fullscreen = 0
			yield(get_tree(), "idle_frame")
			self.popup_centered()
		1:
			OS.set_window_fullscreen(true)
			ClickPlayer._click_sound()
			Settingsholder.save_data.Fullscreen = 1
			yield(get_tree(), "idle_frame")
			self.popup_centered()

# Vsync
func _on_VsyncCheckBtn_pressed():
	Settingsholder.save_data.VsyncEnabled = !Settingsholder.save_data.VsyncEnabled
	OS.set_use_vsync(Settingsholder.save_data.VsyncEnabled)
	ClickPlayer._click_sound()

# Max Fps
func _on_MaxFpsSlider_value_changed(MaxFps):
	MaxFpsValue.set_text(str(MaxFps))
	Settingsholder.save_data.FrameRate = MaxFps
	Engine.set_target_fps(int(Settingsholder.save_data.FrameRate))

# Show Fps
func _on_ShowFpsCheckBtn_pressed():
	Settingsholder.save_data.ShowFps = !Settingsholder.save_data.ShowFps
	ClickPlayer._click_sound()
	Settingsholder.emit_signal("fps_changed")

# Sensitivity
func _on_MouseSensitivitySlider_value_changed(Sensitivity):
	MouseSensitivityVal.set_text(str(Sensitivity))
	Settingsholder.save_data.MouseSensitivity = Sensitivity
	Settingsholder.emit_signal("sens_changed")

# Fov
func _on_FovSlider_value_changed(CurrentFov):
	Settingsholder.save_data.PlayerFOV = CurrentFov
	FovVal.set_text(str(CurrentFov))
	Settingsholder.emit_signal("fov_changed")

# Enable/Disable Bloom
func _on_BloomCheckBtn_pressed():
	Settingsholder.save_data.BloomSet = !Settingsholder.save_data.BloomSet
	Settingsholder.emit_signal("bloom_changed")
	ClickPlayer._click_sound()

# Adjust Brightness
func _on_BrightnessSlider_value_changed(CurrentBrightness):
	Settingsholder.save_data.Brightness = CurrentBrightness
	Settingsholder.emit_signal("brightness_changed")

# Master Volume
func _on_MasterVolSlider_value_changed(MasVol):
	Settingsholder.save_data.MasterVolume = MasVol
	MasVol = MasVol - 40
	AudioServer.set_bus_volume_db(0, MasVol)

# Music Volume
func _on_MusicVolSlider_value_changed(MusVol):
	Settingsholder.save_data.MusicVolume = MusVol
	MusVol = MusVol - 50
	AudioServer.set_bus_volume_db(1, MusVol)

# Sound Effects/Sfx Volume
func _on_SfxVolSlider_value_changed(SfVol):
	Settingsholder.save_data.SfxVolume = SfVol
	SfVol = SfVol - 50
	AudioServer.set_bus_volume_db(2, SfVol)

func _on_SettingsTabs_tab_changed(_tab):
	ClickPlayer._click_sound()

# Clear SaveGame
func _on_ClearSaveBtn_pressed():
	ClickPlayer._click_sound()
	dir.remove(save_data)
	Settingsholder.save_data.Intro = 0
	Settingsholder._save()
	get_tree().quit()

# Set settings to defaults
func _on_DefaultBtn_pressed():
	ClickPlayer._click_sound()
	Settingsholder._default()
	_ready()
	$SettingsTabs/Gameplay/MarginContainer/GameplaySettings/DefaultBtn.pressed = false


# GAMEPLAY SETTINGS

func _on_FXAACheck_pressed():
	ClickPlayer._click_sound()
	pass # Replace with function body.
