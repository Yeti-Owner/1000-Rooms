extends CanvasLayer

var Stamina = 200

# References
onready var RoomNum = $RoomNumHolder/CenterContainer/RoomNum
onready var FpsCounter = $MarginContainer/FpsCounter
onready var HpBar = $HPandStam/HpBar2
onready var StamBar = $HPandStam/StamBar2

func _ready():
# warning-ignore:return_value_discarded
	AchievementsHolder.connect("NewAchievement", self, "_achievement")
	StamBar.set_value(Stamina)
	RoomNum.set_text("Room: " + str(SaveGame.game_data.RoomNum))
	HpBar.set_value(SaveGame.game_data.PlayerHP)
# warning-ignore:return_value_discarded
	Settingsholder.connect("fps_changed", self, "_update_vals")


func _physics_process(_delta) -> void:
	# Regen Stamina Bar
	if !Input.is_action_pressed("sprint") && StamBar.get_value() < 200:
		Stamina = StamBar.get_value() + 0.5
		StamBar.set_value(Stamina)
	
	# Update HP bar
	HpBar.set_value(SaveGame.game_data.PlayerHP)

func _achievement():
	$AnimationPlayer.play("Achievement")

func _on_UpdateTimer_timeout():
	_update_vals()

func _update_vals():
	# Show FPS if enabled
	if Settingsholder.ShowFps:
		$MarginContainer.set_visible(true)
		FpsCounter.text = str("Fps: " + str(Performance.get_monitor(Performance.TIME_FPS)))
	else:
		$MarginContainer.set_visible(false)
	
	# Room Num
	RoomNum.set_text("Room: " + str(SaveGame.game_data.RoomNum))
