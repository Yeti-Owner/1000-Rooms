extends Control

onready var ClickPlayer = get_node("SettingsMenu/ClickPlayer")
onready var MusicPlayer = get_parent().get_node("MusicPlayer")

func _ready():
	SaveGame._update_presence()
	$VersionChecker._start()
	SceneManager.HudMode = "none"

func _on_StartBtn_pressed():
	$Timer.start()
	MusicPlayer._music_transition()
	ClickPlayer._click_sound()
	SceneManager._change_scene(SaveGame.game_data.CurrentRoom)
#	SceneManager.HudMode = "ingame"

func _on_OptionsBtn_pressed():
	ClickPlayer._click_sound()
	$SettingsMenu.popup_centered()

func _on_AchievementsBtn_pressed():
	get_node("Achievements").popup_centered()

func _on_CreditsBtn_pressed():
	pass
#	var _error = get_tree().change_scene("res://scenes/Credits.tscn")

func _on_QuitBtn_pressed():
	ClickPlayer._click_sound()
	Settingsholder._save()
	AchievementsHolder._save()
	get_tree().quit()


func _on_VersionBtn_pressed():
	get_node("VersionDialog").popup_centered()

func _on_CloseBtn_pressed():
	get_node("VersionDialog").visible = false

func _on_FeedbackBtn_pressed():
	var _error = OS.shell_open("https://forms.gle/FtncNqYqHXxhzjqg7")

func _on_Timer_timeout():
	SceneManager.HudMode = "ingame"
