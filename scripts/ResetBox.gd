extends Area

func _on_ResetBox_area_entered(area):
	if area.name == "PlayerArea":
		SaveGame.game_data.PlayerHP -= 5
		var _error = get_tree().reload_current_scene()
