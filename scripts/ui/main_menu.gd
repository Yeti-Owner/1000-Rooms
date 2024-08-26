extends Control

func _ready():
	EventBus.fader._fade_in(Color(0,0,0))

func _on_start_pressed():
	EventBus.fader._fade_out(Color(0,0,0))
	await EventBus.fader.fade_done
	SceneManager._change_scene("GAME", "res://rooms/100/room_1.tscn")

func _on_options_pressed():
	pass

func _on_secrets_pressed():
	pass

func _on_quit_pressed():
	EventBus._quit()
