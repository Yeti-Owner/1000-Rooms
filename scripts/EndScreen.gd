extends Control

func _ready():
	SceneManager.CurrentScene = null
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Button_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://forms.gle/FtncNqYqHXxhzjqg7")

func _on_MainMenuBtn_pressed():
	SceneManager._change_scene("res://scenes/StartMenuScene.tscn")
