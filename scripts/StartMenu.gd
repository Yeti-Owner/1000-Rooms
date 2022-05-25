extends Control

onready var fader = $Fader

func _ready():
	fader.connect("fade_finished", self, "on_fade_finished")

func _on_StartBtn_pressed():
	fader._fade_out()

func _on_OptionsBtn_pressed():
	$Fader/SettingsMenu.popup_centered()

func _on_QuitBtn_pressed():
	Settingsholder._save()
	get_tree().quit()

func on_fade_finished():
	var _error = get_tree().change_scene("res://scenes/world.tscn")
