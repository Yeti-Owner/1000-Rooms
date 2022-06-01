extends CanvasLayer

var Stamina = 150

# References
onready var RoomNum = $RoomNumHolder/CenterContainer/RoomNum
onready var FpsCounter = $MarginContainer/FpsCounter
onready var HpBar = $HPandStam/HBoxContainer/HpBar
onready var StamBar = $HPandStam/HBoxContainer2/StamBar

func _ready():
	StamBar.set_value(Stamina)
	RoomNum.set_text("Room: " + str(Settingsholder.RoomNum))

func _process(_delta):
	# Show FPS if enabled
	if Settingsholder.ShowFps:
		$MarginContainer.set_visible(true)
		FpsCounter.text = str("Fps: " + str(Performance.get_monitor(Performance.TIME_FPS)))
	else:
		$MarginContainer.set_visible(false)
	
	# Update HP bar
	HpBar.set_value(Settingsholder.PlayerHP)
	
	# Regen Stamina Bar
	if !Input.is_action_pressed("sprint") && StamBar.get_value() < 150:
		Stamina = StamBar.get_value() + 0.5
		StamBar.set_value(Stamina)

