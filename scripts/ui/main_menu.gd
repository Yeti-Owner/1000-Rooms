extends Control

func _ready():
	pass

func _on_start_pressed():
	# EventBus._change_scene(self, "res://scenes/ui/main_menu.tscn")
	pass

func _on_options_pressed():
	pass

func _on_secrets_pressed():
	pass

func _on_quit_pressed():
	EventBus._quit()
