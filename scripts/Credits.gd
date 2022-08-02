extends Control

func _process(delta):
	if $CreditsText.rect_position.y >= -100:
		$CreditsText.rect_position.y -= 0.02

func _on_CloseBtn_pressed():
	get_tree().change_scene("res://scenes/StartMenuV2.tscn")
