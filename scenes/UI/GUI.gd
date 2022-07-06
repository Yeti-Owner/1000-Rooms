extends CanvasLayer

var Stamina = 200

# References
onready var RoomNum = $RoomNumHolder/CenterContainer/RoomNum
onready var FpsCounter = $MarginContainer/FpsCounter
onready var HpBar = $HPandStam/HpBar2
onready var StamBar = $HPandStam/StamBar2

func _ready():
	StamBar.set_value(Stamina)
	RoomNum.set_text("Room: " + str(SaveGame.game_data.RoomNum))
	HpBar.set_value(SaveGame.game_data.PlayerHP)

func _process(_delta) -> void:
	# Show FPS if enabled
	if Settingsholder.ShowFps:
		$MarginContainer.set_visible(true)
		FpsCounter.text = str("Fps: " + str(Performance.get_monitor(Performance.TIME_FPS)))
	else:
		$MarginContainer.set_visible(false)
	
	# Update HP bar
	HpBar.set_value(SaveGame.game_data.PlayerHP)
	
#	# Regen Stamina Bar
#	if !Input.is_action_pressed("sprint") && StamBar.get_value() < 200:
#		Stamina = StamBar.get_value() + 0.5
#		StamBar.set_value(Stamina)
#
	# Room Num
	RoomNum.set_text("Room: " + str(SaveGame.game_data.RoomNum))

func _physics_process(_delta) -> void:
	# Regen Stamina Bar
	if !Input.is_action_pressed("sprint") && StamBar.get_value() < 200:
		Stamina = StamBar.get_value() + 0.5
		StamBar.set_value(Stamina)

