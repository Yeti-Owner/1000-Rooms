extends Interactable

@export var RoomAmt: int = 5

func _ready():
	$AnimationPlayer.play("Hover")

func get_interaction_text():
	return ("Press %s to collect" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)])

func interact():
	SaveGame.game_data.RoomNum += RoomAmt
	self.queue_free()
