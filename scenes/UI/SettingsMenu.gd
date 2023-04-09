extends Control

# Cleaned up referencing
@onready var MaxFpsValue := $Holder/SettingsTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsValue
@onready var MaxFpsSlider := $Holder/SettingsTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsSlider
@onready var VsyncCheckBtn := $Holder/SettingsTabs/Video/MarginContainer/VideoSettings/VsyncCheckBtn
@onready var ShowFpsCheckBtn := $Holder/SettingsTabs/Video/MarginContainer/VideoSettings/ShowFpsCheckBtn
@onready var FovVal := $Holder/SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovVal
@onready var FovSlider := $Holder/SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovSlider
@onready var MouseSensitivityVal := $Holder/SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer2/MouseSensitivityVal
@onready var MouseSensitivitySlider := $Holder/SettingsTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer2/MouseSensitivitySlider
@onready var BloomCheckBtn := $Holder/SettingsTabs/Video/MarginContainer/VideoSettings/BloomCheckBtn
@onready var BrightnessSlider := $Holder/SettingsTabs/Video/MarginContainer/VideoSettings/BrightnessSlider
@onready var MasterVol := $Holder/SettingsTabs/Audio/MarginContainer/AudioSettings/MasterVolSlider
@onready var MusicVol := $Holder/SettingsTabs/Audio/MarginContainer/AudioSettings/MusicVolSlider
@onready var SfxVol := $Holder/SettingsTabs/Audio/MarginContainer/AudioSettings/SfxVolSlider
@onready var ClickPlayer := $Holder/ClickPlayer
@onready var FullScreenOption := $Holder/SettingsTabs/Video/MarginContainer/VideoSettings/DisplayOptionBtn
@onready var FXAABtn := $Holder/SettingsTabs/Graphics/MarginContainer/GameplaySettings/FXAA/FXAACheck
@onready var MSAAOption := $Holder/SettingsTabs/Graphics/MarginContainer/GameplaySettings/MSAA/MSAAOptions
@onready var ScaleText := $Holder/SettingsTabs/Graphics/MarginContainer/GameplaySettings/VBoxContainer/HBoxContainer/ScaleText
@onready var ScaleSlider := $Holder/SettingsTabs/Graphics/MarginContainer/GameplaySettings/VBoxContainer/HBoxContainer/ResolutionScale
@onready var QualBloomBtn := $Holder/SettingsTabs/Graphics/MarginContainer/GameplaySettings/QualityBloom/QualBloomCheck

func _ready():
	self.hide()
	
	# Set FPS to correct value
	Engine.set_max_fps(int(Settingsholder.save_data.FrameRate))
	
	# Set Windowd/Fullscreen
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (Settingsholder.save_data.Fullscreen) else Window.MODE_WINDOWED
	
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
	FXAABtn.button_pressed = Settingsholder.save_data.FXAA
	MSAAOption.selected = Settingsholder.save_data.MSAA
	ScaleText.text = Settingsholder.save_data.ResolutionText
	ScaleSlider.value = Settingsholder.save_data.ResolutionScale
	QualBloomBtn.set_pressed_no_signal(Settingsholder.save_data.QualityBloom)
	
	_viewport_settings()

func _viewport_settings():
#	get_node("/root/SceneManager/GameScene/GameViewport").fxaa = Settingsholder.save_data.FXAA
	get_node("/root/SceneManager/GameScene/GameViewport").set_msaa_3d(Settingsholder.save_data.MSAA)
	
	var resolutions := [Vector2(848,480),Vector2(960, 540),Vector2(1024,576),Vector2(1280,720),Vector2(1366,768),Vector2(1600,900),Vector2(1920,1080),Vector2(2560,1440)]
	get_node("/root/SceneManager/GameScene/GameViewport").set_size(resolutions[Settingsholder.save_data.ResolutionScale])

# Windowed/Fullscreen option
func _on_display_option_btn_item_selected(index):
	match index:
		0:
			get_window().set_mode(Window.MODE_FULLSCREEN)
			ClickPlayer._click_sound()
			Settingsholder.save_data.Fullscreen = 0
		1:
			get_window().set_mode(Window.MODE_WINDOWED)
			ClickPlayer._click_sound()
			Settingsholder.save_data.Fullscreen = 1

# Vsync
func _on_vsync_check_btn_pressed():
	Settingsholder.save_data.VsyncEnabled = !Settingsholder.save_data.VsyncEnabled
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (Settingsholder.save_data.VsyncEnabled) else DisplayServer.VSYNC_DISABLED)
	ClickPlayer._click_sound()

# Max Fps
func _on_max_fps_slider_value_changed(value):
	MaxFpsValue.set_text(str(value))
	Settingsholder.save_data.FrameRate = value
	Engine.set_max_fps(int(Settingsholder.save_data.FrameRate))

# Show Fps
func _on_show_fps_check_btn_pressed():
	Settingsholder.save_data.ShowFps = !Settingsholder.save_data.ShowFps
	ClickPlayer._click_sound()
	Settingsholder.emit_signal("fps_changed")

# Sensitivity
func _on_mouse_sensitivity_slider_value_changed(value):
	MouseSensitivityVal.set_text(str(value))
	Settingsholder.save_data.MouseSensitivity = value
	Settingsholder.emit_signal("sens_changed")

# Fov
func _on_fov_slider_value_changed(value):
	Settingsholder.save_data.PlayerFOV = value
	FovVal.set_text(str(value))
	Settingsholder.emit_signal("fov_changed")

# Enable/Disable Bloom
func _on_bloom_check_btn_pressed():
	Settingsholder.save_data.BloomSet = !Settingsholder.save_data.BloomSet
	if !(Settingsholder.save_data.BloomSet):
		Settingsholder.save_data.QualityBloom = 0
		Settingsholder.emit_signal("quality_bloom_changed")
		QualBloomBtn.set_pressed_no_signal(Settingsholder.save_data.QualityBloom)
	Settingsholder.emit_signal("bloom_changed")
	ClickPlayer._click_sound()
	QualBloomBtn.set_pressed_no_signal(Settingsholder.save_data.QualityBloom)

# Adjust Brightness
func _on_brightness_slider_drag_ended(value_changed):
	Settingsholder.save_data.Brightness = value_changed
	Settingsholder.emit_signal("brightness_changed")

# Master Volume
func _on_master_vol_slider_value_changed(value):
	Settingsholder.save_data.MasterVolume = value
	value = value - 40
	AudioServer.set_bus_volume_db(0, value)

# Music Volume
func _on_music_vol_slider_value_changed(value):
	Settingsholder.save_data.MusicVolume = value
	value = value - 50
	AudioServer.set_bus_volume_db(1, value)

# Sound Effects/Sfx Volume
func _on_sfx_vol_slider_value_changed(value):
	Settingsholder.save_data.SfxVolume = value
	value = value - 50
	AudioServer.set_bus_volume_db(2, value)

# Clear SaveGame
func _on_clear_save_btn_pressed():
	ClickPlayer._click_sound()
	SaveGame._clear_save()
	$Holder/SettingsTabs/Gameplay/MarginContainer/GameplaySettings/ClearSaveBtn.button_pressed = false
	self.visible = false

# Set settings to defaults
func _on_default_btn_pressed():
	ClickPlayer._click_sound()
	Settingsholder._default()
	_ready()
	$Holder/SettingsTabs/Gameplay/MarginContainer/GameplaySettings/DefaultBtn.button_pressed = false

# GAMEPLAY SETTINGS
func _on_FXAACheck_pressed():
	ClickPlayer._click_sound()
	Settingsholder.save_data.FXAA = !Settingsholder.save_data.FXAA
	_viewport_settings()

func _on_msaa_options_item_selected(index):
	ClickPlayer._click_sound()
	Settingsholder.save_data.MSAA = index
	_viewport_settings()

func _on_resolution_scale_value_changed(value):
	Settingsholder.save_data.ResolutionScale = value
	var ResolutionText := ["480p","540p","576p","720p","768p","900p","1080p","1440p"]
	Settingsholder.save_data.ResolutionText = ResolutionText[value]
	ScaleText.text = Settingsholder.save_data.ResolutionText
	_viewport_settings()

func _on_qual_bloom_check_pressed():
	Settingsholder.save_data.QualityBloom = !Settingsholder.save_data.QualityBloom
	if (Settingsholder.save_data.QualityBloom):
		Settingsholder.save_data.BloomSet = 1
		BloomCheckBtn.set_pressed_no_signal(Settingsholder.save_data.BloomSet)
	ClickPlayer._click_sound()
	BloomCheckBtn.set_pressed_no_signal(Settingsholder.save_data.BloomSet)
	Settingsholder.emit_signal("quality_bloom_changed")

func _on_click_out_pressed():
	self.hide()

func _on_close_pressed():
	self.hide()

func _on_settings_tabs_tab_changed(_tab):
	ClickPlayer._click_sound()

