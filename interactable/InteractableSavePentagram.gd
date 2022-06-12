extends Interactable

onready var player = get_node("/root/world/Fader/Player")

func get_interaction_text():
	return "Press E to Save"

func interact():
	SaveGame.game_data.LastCheckPoint = SaveGame.game_data.CurrentRoom
	SaveGame.game_data.LastSavedRoom = SaveGame.game_data.RoomNum
	SaveGame.game_data.CurrentPos = player.transform.origin
	SaveGame._save()
