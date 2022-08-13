extends Control

func _physics_process(_delta) -> void:
	if $CreditsText.rect_position.y >= -100:
		$CreditsText.rect_position.y -= 0.3

func _unhandled_input(event):
	$CreditsText.rect_position.y = -100

func _on_CloseBtn_pressed():
	get_tree().change_scene("res://scenes/StartMenuV2.tscn")
