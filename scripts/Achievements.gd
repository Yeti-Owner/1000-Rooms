extends CanvasLayer

@onready var MaxRoomLabel := $Control/RoomsPopup/Label
@onready var RoomNumChanger := $Control/RoomsPopup/RoomNumChanger

signal LeftA
signal RightA

func _ready():
	MaxRoomLabel.text = str("Highest available room number is: " + str(SaveGame.game_data.MaxRoomNum))
	RoomNumChanger.max_value = SaveGame.game_data.MaxRoomNum
	RoomNumChanger.value = RoomNumChanger.max_value

func _on_CloseBtn_pressed():
	self.visible = false

func _on_Left_pressed():
	emit_signal("LeftA")

func _on_Right_pressed():
	emit_signal("RightA")

func _on_Close_pressed():
	SceneManager._change_scene("res://scenes/StartMenuScene.tscn", "achievement")

func _on_PastLevels_pressed():
	$Control/RoomsPopup.popup_centered()

func _on_ConfirmBtn_pressed():
	SaveGame.game_data.RoomNum = RoomNumChanger.value
