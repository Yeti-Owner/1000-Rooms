extends CanvasLayer

onready var RoomNum := $RoomNumHolder/CenterContainer/RoomNum
onready var FpsCounter := $MarginContainer/FpsCounter
onready var HpBar := $HPandStam/HpBar2
onready var StamBar := $HPandStam/StamBar2

var Stamina:float = 200

func _ready():
	StamBar.set_value(Stamina)
	RoomNum.set_text("Room: " + str(SaveGame.game_data.RoomNum))
	HpBar.set_value(SaveGame.game_data.PlayerHP)
# warning-ignore:return_value_discarded
	Settingsholder.connect("fps_changed", self, "_update_vals")
# warning-ignore:return_value_discarded
	Settingsholder.connect("hp_changed", self, "_update_hp")


func _on_UpdateTimer_timeout():
	_update_vals()

func _update_hp():
	HpBar.set_value(SaveGame.game_data.PlayerHP)

func _update_vals():
	# Show FPS if enabled
	if Settingsholder.save_data.ShowFps:
		$MarginContainer.set_visible(true)
		FpsCounter.text = str("Fps: " + str(Performance.get_monitor(Performance.TIME_FPS)))
	else:
		$MarginContainer.set_visible(false)
	
	# Room Num
	RoomNum.set_text("Room: " + str(SaveGame.game_data.RoomNum))


func _on_StamRegen_timeout():
	if !Input.is_action_pressed("sprint") and !get_tree().paused:
			Stamina = min(StamBar.get_value() + 3.75, 200)
			StamBar.set_value(Stamina)
