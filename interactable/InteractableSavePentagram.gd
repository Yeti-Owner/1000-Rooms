extends Interactable

var Saved = "Press E to Save"
export(Vector3) var CurrentPos

func get_interaction_text():
	return Saved

func interact():
	$SaveSound.play()
	SaveGame.game_data.LastCheckPoint = SaveGame.game_data.CurrentRoom
	SaveGame.game_data.LastSavedRoom = SaveGame.game_data.RoomNum
	SaveGame.game_data.MaxRoomNum = SaveGame.game_data.RoomNum
	SaveGame.game_data.CurrentPos = CurrentPos
	SaveGame._save()
	AchievementsHolder._save()
	Saved = "Game has been saved"
