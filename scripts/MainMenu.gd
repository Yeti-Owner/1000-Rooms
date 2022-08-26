extends Control

onready var fader = get_parent()
onready var ClickPlayer = get_node("SettingsMenu/ClickPlayer")
onready var MusicPlayer = get_node("/root/StartMenuV2/MusicPlayer")

func _ready():
	if Settingsholder.Intro == 0:
		OS.set_window_fullscreen(false)
		Settingsholder.Fullscreen = 0
		var _error = get_tree().change_scene("res://scenes/Room0.tscn")
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		fader.connect("fade_finished", self, "on_fade_finished")
		SaveGame._update_presence()
		

func _on_StartBtn_pressed():
	MusicPlayer._music_transition()
	ClickPlayer._click_sound()
	fader._fade_out()

func _on_OptionsBtn_pressed():
	ClickPlayer._click_sound()
	$SettingsMenu.popup_centered()

func _on_AchievementsBtn_pressed():
	get_node("Achievements").popup_centered()

func _on_CreditsBtn_pressed():
	var _error = get_tree().change_scene("res://scenes/Credits.tscn")

func _on_QuitBtn_pressed():
	ClickPlayer._click_sound()
	Settingsholder._save()
	AchievementsHolder._save()
	get_tree().quit()

func on_fade_finished():
	var _error = get_tree().change_scene(SaveGame.game_data.CurrentRoom)

func _on_VersionBtn_pressed():
	get_node("VersionDialog").popup_centered()

func _on_CloseBtn_pressed():
	get_node("VersionDialog").visible = false

func _on_FeedbackBtn_pressed():
	var _error = OS.shell_open("https://forms.gle/FtncNqYqHXxhzjqg7")
