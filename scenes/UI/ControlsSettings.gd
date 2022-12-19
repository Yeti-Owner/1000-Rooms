extends MarginContainer

onready var KeyTester := InputEventKey.new()
onready var AnimPlayer := $Extras/AnimationPlayer

var ActionsList = ["up","down","left","right","jump","sprint","interact","pause","console","primary","secondary"]
var Action
var KeyChanging
var ButtonChanging
var OldKey
var EnableInput = false

func _ready():
	var num = 0
	for child in $Buttons.get_children():
		if num <9:
			child.get_node("Bound").text = OS.get_scancode_string(InputMap.get_action_list(ActionsList[num])[0].scancode)
		num += 1

func _check_key(key):
	var HasKey = false
	var i = 0
	KeyTester = key
	
	while (HasKey == false) and (i < 11):
		HasKey = InputMap.action_has_event(ActionsList[i], KeyTester)
		i += 1
	
	return HasKey

func _assign_key(key):
	InputMap.action_erase_events(Action)
	InputMap.action_add_event(Action, key)


func _input(event):
	if EnableInput:
		if event is InputEventKey:
			var isUsed = _check_key(event)
			if isUsed:
				AnimPlayer.play("KeyUsed")
				EnableInput = false
				KeyChanging.text = OldKey
				ButtonChanging.text = "Change"
			else:
				_assign_key(event)
				AnimPlayer.play("RESET")
				KeyChanging.text = str(char(event.unicode))
				EnableInput = false
				ButtonChanging.text = "Change"

# Button Signals

func _on_InteractChange_pressed():
	KeyChanging = $Buttons/InteractControl/Bound
	ButtonChanging = $Buttons/InteractControl/Change
	OldKey = KeyChanging.text
	ButtonChanging.text = "..."
	AnimPlayer.play("Waiting")
	EnableInput = true
	Action = "interact"

func _on_ForChange_pressed():
	KeyChanging = $Buttons/ForwardControl/Bound
	ButtonChanging = $Buttons/ForwardControl/Change
	OldKey = KeyChanging.text
	ButtonChanging.text = "..."
	AnimPlayer.play("Waiting")
	EnableInput = true
	Action = "up"

func _on_BackChange_pressed():
	KeyChanging = $Buttons/BackControl/Bound
	ButtonChanging = $Buttons/BackControl/Change
	OldKey = KeyChanging.text
	ButtonChanging.text = "..."
	AnimPlayer.play("Waiting")
	EnableInput = true
	Action = "down"

func _on_LeftChange_pressed():
	KeyChanging = $Buttons/LeftControl/Bound
	ButtonChanging = $Buttons/LeftControl/Change
	OldKey = KeyChanging.text
	ButtonChanging.text = "..."
	AnimPlayer.play("Waiting")
	EnableInput = true
	Action = "left"

func _on_RightChange_pressed():
	KeyChanging = $Buttons/RightControl/Bound
	ButtonChanging = $Buttons/RightControl/Change
	OldKey = KeyChanging.text
	ButtonChanging.text = "..."
	AnimPlayer.play("Waiting")
	EnableInput = true
	Action = "right"

func _on_JumpChange_pressed():
	KeyChanging = $Buttons/JumpControl/Bound
	ButtonChanging = $Buttons/JumpControl/Change
	OldKey = KeyChanging.text
	ButtonChanging.text = "..."
	AnimPlayer.play("Waiting")
	EnableInput = true
	Action = "jump"

func _on_PauseChange_pressed():
	KeyChanging = $Buttons/PauseControl/Bound
	ButtonChanging = $Buttons/PauseControl/Change
	OldKey = KeyChanging.text
	ButtonChanging.text = "..."
	AnimPlayer.play("Waiting")
	EnableInput = true
	Action = "pause"

func _on_ConsoleChange_pressed():
	KeyChanging = $Buttons/ConsoleControl/Bound
	ButtonChanging = $Buttons/ConsoleControl/Change
	OldKey = KeyChanging.text
	ButtonChanging.text = "..."
	AnimPlayer.play("Waiting")
	EnableInput = true
	Action = "console"

func _on_SprintChange_pressed():
	KeyChanging = $Buttons/SprintControl/Bound
	ButtonChanging = $Buttons/SprintControl/Change
	OldKey = KeyChanging.text
	ButtonChanging.text = "..."
	AnimPlayer.play("Waiting")
	EnableInput = true
	Action = "sprint"
