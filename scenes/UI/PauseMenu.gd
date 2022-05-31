extends Control
var isPaused = false setget set_is_paused

onready var VCont = $VBoxContainer
onready var ClickPlayer = $SettingsMenu/ClickPlayer

func _ready():
	# Math to center the pause menu based off window size
	var CenterOfScreen = Vector2(OS.get_window_size().x/2, OS.get_window_size().y/2)
	CenterOfScreen.y = CenterOfScreen.y - VCont.get_size().y/2
	CenterOfScreen.x = CenterOfScreen.x - VCont.get_size().x/0.33
	VCont._set_position(CenterOfScreen)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.isPaused = !isPaused
		# Re-run math to center pause menu incase window changed size
		_ready()

func set_is_paused(value):
	isPaused = value
	get_tree().paused = isPaused
	visible = isPaused
	if (isPaused):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_ResumeBtn_pressed():
	ClickPlayer._click_sound()
	self.isPaused = false

func _on_QuitBtn_pressed():
	ClickPlayer._click_sound()
	Settingsholder._save()
	get_tree().quit()

func _on_OptionsBtn_pressed():
	ClickPlayer._click_sound()
	$SettingsMenu.popup_centered()


func _on_StartMenuBtn_pressed():
	ClickPlayer._click_sound()
	self.isPaused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var _error = get_tree().change_scene("res://scenes/StartMenu.tscn")
