extends Spatial

func _ready():
	if Settingsholder.Intro == 0:
		var _error = get_tree().change_scene("res://scenes/Room0.tscn")
	else:
		var _error = get_tree().change_scene("res://scenes/StartMenuV2.tscn")
