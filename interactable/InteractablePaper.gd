extends Interactable

@export var Title: String = ""
@export var Text = "" # (String, MULTILINE)
@export var TextColor: Color = Color(1,1,1,1)

@onready var TitleText = $CanvasLayer/PopupManager/MarginContainer/VBoxContainer/Title
@onready var TextText = $CanvasLayer/PopupManager/MarginContainer/VBoxContainer/Text

func _ready():
	$CanvasLayer/PopupManager.hide()
#	TitleText.add_theme_color_override("font_color", TextColor)
#	TextText.add_theme_color_override("font_color", TextColor)

func get_interaction_text():
	return "Press %s to read" % [OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode)]

func interact():
	TitleText.text = Title
	TextText.text = Text
	$CanvasLayer/PopupManager.show()
	$PaperNoise.pitch_scale = randf_range(0.80, 1.2)
	$PaperNoise.play()

func _on_Area_area_exited(area):
	if area.name == "PlayerArea":
		$CanvasLayer/PopupManager.hide()

func _on_clickout_pressed():
	$CanvasLayer/PopupManager.hide()
