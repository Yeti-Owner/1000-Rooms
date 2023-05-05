extends Area

func _on_ResetBox_area_entered(area):
	if area.name == "PlayerArea":
		SaveGame.DeathReason = "fall"
		SaveGame.game_data.PlayerHP -= 10
		SceneManager._reload_scene()
		Settingsholder.emit_signal("hp_changed")
