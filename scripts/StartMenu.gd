extends Control


func _on_StartBtn_pressed():
	get_tree().change_scene("res://scenes/world.tscn")

func _on_OptionsBtn_pressed():
	pass # Replace with function body.

func _on_QuitBtn_pressed():
	get_tree().quit()
