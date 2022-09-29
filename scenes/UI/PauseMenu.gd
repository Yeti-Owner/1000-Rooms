extends Control
var isPaused = false setget set_is_paused

onready var VCont = $CenterContainer/VBoxContainer
onready var ClickPlayer = $CanvasLayer/SettingsMenu/ClickPlayer


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.isPaused = !isPaused

func set_is_paused(value):
	isPaused = value
	get_tree().paused = isPaused
	visible = isPaused
	if (isPaused):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_ResumeBtn_pressed():
	ClickPlayer._click_sound()
	self.isPaused = false

func _on_QuitBtn_pressed():
	ClickPlayer._click_sound()
	Settingsholder._save()
	AchievementsHolder._save()
	get_tree().quit()

func _on_OptionsBtn_pressed():
	ClickPlayer._click_sound()
	$CanvasLayer/SettingsMenu.popup_centered()


func _on_StartMenuBtn_pressed():
	ClickPlayer._click_sound()
	self.isPaused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SceneManager._change_scene("res://scenes/StartMenuScene.tscn")
