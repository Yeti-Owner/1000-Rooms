extends Interactable

export(String) var Title = ""
export(String, MULTILINE) var Text = ""
export(Color) var TextColor

func _ready():
	$CanvasLayer/Popup/MarginContainer/VBoxContainer/Title.add_color_override("font_color", TextColor)
	$CanvasLayer/Popup/MarginContainer/VBoxContainer/Text.add_color_override("font_color", TextColor)

func get_interaction_text():
	return "Press E to read"

func interact():
	$CanvasLayer/Popup/MarginContainer/VBoxContainer/Title.text = Title
	$CanvasLayer/Popup/MarginContainer/VBoxContainer/Text.text = Text
	$CanvasLayer/Popup.popup()
	$PaperNoise.pitch_scale = rand_range(0.80, 1.2)
	$PaperNoise.play()

func _on_Area_area_exited(area):
	if area.name == "PlayerArea":
		$CanvasLayer/Popup.visible = false
