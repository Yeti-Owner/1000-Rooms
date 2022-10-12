extends CanvasLayer

signal LeftA
signal RightA

func _on_CloseBtn_pressed():
	self.visible = false

func _on_Left_pressed():
	emit_signal("LeftA")

func _on_Right_pressed():
	emit_signal("RightA")

func _on_Close_pressed():
	SceneManager._change_scene("res://scenes/StartMenuScene.tscn", "achievement")
	
