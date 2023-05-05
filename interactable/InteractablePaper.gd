extends Interactable

export(String) var Title = ""
export(String, MULTILINE) var Text = ""
export(Color) var TextColor = Color(1,1,1,1)

onready var TitleText = $CanvasLayer/Popup/MarginContainer/VBoxContainer/Title
onready var TextText = $CanvasLayer/Popup/MarginContainer/VBoxContainer/Text

func _ready():
	TitleText.add_color_override("font_color", TextColor)
	TextText.add_color_override("font_color", TextColor)

func get_interaction_text():
	return "Press %s to read" % [OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)]

func interact():
	TitleText.text = Title
	TextText.text = Text
	$CanvasLayer/Popup.popup()
	$PaperNoise.pitch_scale = rand_range(0.80, 1.2)
	$PaperNoise.play()

func _on_Area_area_exited(area):
	if area.name == "PlayerArea":
		$CanvasLayer/Popup.visible = false
