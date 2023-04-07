extends Node

func _ready():
	if SaveGame.game_data.Intro == 0:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (false) else Window.MODE_WINDOWED
		Settingsholder.save_data.Fullscreen = 0
		SceneManager._change_scene("res://scenes/Room0.tscn")
		queue_free()
	else:
		Settingsholder._apply_keybinds()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		SceneManager._change_scene("res://scenes/StartMenuScene.tscn")
		queue_free()
