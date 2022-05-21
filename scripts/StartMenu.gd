extends Control


func _on_StartBtn_pressed():
	var _error = get_tree().change_scene("res://scenes/world.tscn")

func _on_OptionsBtn_pressed():
	$SettingsMenu.popup_centered()

func _on_QuitBtn_pressed():
	get_tree().quit()
