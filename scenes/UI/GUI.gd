extends CanvasLayer

onready var RoomNum := $RoomNumHolder/CenterContainer/RoomNum
onready var FpsCounter := $MarginContainer/FpsCounter
onready var HpBar := $HPandStam/HpBar2
onready var StamBar := $HPandStam/StamBar2

var Stamina := 200
var isPaused := false

func _ready():
	StamBar.set_value(Stamina)
	RoomNum.set_text("Room: " + str(SaveGame.game_data.RoomNum))
	HpBar.set_value(SaveGame.game_data.PlayerHP)
# warning-ignore:return_value_discarded
	Settingsholder.connect("fps_changed", self, "_update_vals")
# warning-ignore:return_value_discarded
	Settingsholder.connect("hp_changed", self, "_update_hp")

func _physics_process(_delta) -> void:
	# Regen Stamina Bar
	if !Input.is_action_pressed("sprint") && StamBar.get_value() < 200:
		isPaused = get_tree().paused
		if !isPaused:
			Stamina = StamBar.get_value() + 0.5
			StamBar.set_value(Stamina)

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
