extends Interactable

@export var is_locked:bool = true
var used:bool = false

func _ready():
	pass 

func get_interaction_text():
	if (used == true):
		return ""
	elif is_locked == true:
		return "[center][color=BLACK]The door is locked[/color][/center]"
	else:
		return "[center][color=BLACK]Open door?[/color][/center]"

func get_interaction_icon():
	if (is_locked == true) or (used == true):
		return EventBus.default_crosshair
	else:
		return EventBus.interact_crosshair

func interact():
	if (is_locked == false) and (used == false):
		$Anims.play("open")
		used = true
		
		var next_room:String = RoomLoader._find_next(EventBus.room_num)
		EventBus.fader._fade_out(Color(0,0,0))
		await EventBus.fader.fade_done
		SceneManager._change_scene("GAME", next_room)
