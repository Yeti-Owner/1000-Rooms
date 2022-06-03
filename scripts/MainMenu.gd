extends Control

var dir = Directory.new()
var save_game = "user://save_game.dat"
onready var fader = get_parent()
onready var ClickPlayer = get_node("SettingsMenu/ClickPlayer")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	fader.connect("fade_finished", self, "on_fade_finished")

#func _process(delta):
#	pass

func _on_StartBtn_pressed():
	ClickPlayer._click_sound()
	fader._fade_out()

func _on_OptionsBtn_pressed():
	ClickPlayer._click_sound()
	$SettingsMenu.popup_centered()

func _on_ClearSaveBtn_pressed():
	ClickPlayer._click_sound()
	dir.remove(save_game)
	get_tree().quit()

func _on_QuitBtn_pressed():
	ClickPlayer._click_sound()
	Settingsholder._save()
	get_tree().quit()

func on_fade_finished():
	var _error = get_tree().change_scene(Settingsholder.CurrentRoom)

func _on_VersionBtn_pressed():
	get_node("VersionDialog").popup_centered()


func _on_CloseBtn_pressed():
	get_node("VersionDialog").visible = false
