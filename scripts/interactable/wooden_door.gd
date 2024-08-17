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
