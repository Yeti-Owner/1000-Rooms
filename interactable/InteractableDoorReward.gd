extends Interactable
export(int) var RoomAmt = 5

func _ready():
	$AnimationPlayer.play("Hover")

func get_interaction_text():
	return "Press E to collect"

func interact():
	SaveGame.game_data.RoomNum += RoomAmt
	self.queue_free()
