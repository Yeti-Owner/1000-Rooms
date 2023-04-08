extends Control

@onready var ClickPlayer := get_node("SettingsMenu/Holder/ClickPlayer")
@onready var MusicPlayer := get_parent().get_node("MusicPlayer")

var TitleTexts := ["Made by YetiOwner","Feedback appreciated","Almost no bloody handprints!","You have nice hair!","Ngl I'm pretty bad at gamedev","I would kill for a 3D Sphinx model","Graphics Update!!!!","Does anyone read these?","It took way too long to make this","Your Jordans are fake","This was a Graphics and tweaks update","Thank you to all my playtesters","No one has gotten 100% Achievements yet","I bet you have good music taste"]
var TitleLocs := [Vector2(135,134),Vector2(336,276),Vector2(916,154),Vector2(373,592),Vector2(1066,431)]

func _ready():
	randomize()
	SaveGame._update_presence()
#	$VersionChecker._start()
	$TitleText.position = TitleLocs[randi() % TitleLocs.size()]
	$TitleText.rotation = randf_range(-28, 28)
	$TitleText.text = TitleTexts[randi() % TitleTexts.size()]

func _on_StartBtn_pressed():
	$Timer.start()
	MusicPlayer._music_transition()
	ClickPlayer._click_sound()
	SceneManager._change_scene(SaveGame.game_data.CurrentRoom)

func _on_OptionsBtn_pressed():
	ClickPlayer._click_sound()
	$SettingsMenu.show()

func _on_AchievementsBtn_pressed():
	SceneManager._change_scene("res://scenes/AchievementRenderer.tscn", "achievement")
	SceneManager._init_HUD("achievement")

func _on_CreditsBtn_pressed():
	pass

func _on_VersionBtn_pressed():
	get_node("VersionDialog").popup_centered()

func _on_CloseBtn_pressed():
	get_node("VersionDialog").visible = false

func _on_FeedbackBtn_pressed():
	var _error = OS.shell_open("https://forms.gle/FtncNqYqHXxhzjqg7")

func _on_Timer_timeout():
	SceneManager.HudMode = "ingame"

func _on_quit_btn_pressed():
	ClickPlayer._click_sound()
	Settingsholder._save(Settingsholder.save_settings, Settingsholder.save_data)
	Settingsholder._save(Settingsholder.save_keybinds, Settingsholder.keybinds_data)
	AchievementsHolder._save()
	get_tree().quit()
