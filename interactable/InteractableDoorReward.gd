extends Interactable
export(int) var RoomAmt = 5

func _ready():
	$AnimationPlayer.play("Hover")

func get_interaction_text():
	return ("Press %s to collect" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)])

func interact():
	SaveGame.game_data.RoomNum += RoomAmt
	self.queue_free()
