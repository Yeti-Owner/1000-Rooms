extends Interactable

export(String) var Title = ""
export(String) var Text = ""

func get_interaction_text():
	return "Press E to read"

func interact():
	$Popup/TextureRect/VBoxContainer/Title.text = Title
	$Popup/TextureRect/VBoxContainer/Text.text = Text
	$Popup.popup()

func _on_Area_area_exited(area):
	if area.name == "PlayerArea":
		$Popup.visible = false
