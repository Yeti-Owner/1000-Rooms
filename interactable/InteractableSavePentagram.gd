extends Interactable

var Saved = "Press E to Save"
onready var player = get_node("/root/world/Fader/Player")
onready var SaveSound = get_parent().get_node("SaveSound")

func get_interaction_text():
	return Saved

func interact():
	SaveSound.play()
	SaveGame.game_data.LastCheckPoint = SaveGame.game_data.CurrentRoom
	SaveGame.game_data.LastSavedRoom = SaveGame.game_data.RoomNum
	SaveGame.game_data.CurrentPos = player.transform.origin
	SaveGame._save()
	Saved = "Game has been saved"
