extends Node

func _ready():
	SaveGame.game_data.Intro = 1
	if SaveGame.game_data.Intro == 0:
		get_window().set_mode(Window.MODE_WINDOWED)
		Settingsholder.save_data.Fullscreen = 0
		SceneManager._change_scene("res://scenes/Room0.tscn")
		self.queue_free()
	else:
		Settingsholder._apply_keybinds()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		SceneManager._change_scene("res://scenes/StartMenuScene.tscn")
		self.queue_free()
