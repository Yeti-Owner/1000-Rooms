extends Control

func _ready():
	pass

func _on_start_pressed():
	SceneManager._change_scene("GAME", "res://rooms/100/room_1.tscn")

func _on_options_pressed():
	pass

func _on_secrets_pressed():
	pass

func _on_quit_pressed():
	EventBus._quit()
