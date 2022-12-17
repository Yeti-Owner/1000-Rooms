extends Control

func _ready():
	$AnimationPlayer.play("Credits")
	$CloseBtn.visible = false

func _unhandled_input(_event):
	$CloseBtn.visible = true

func _on_CloseBtn_pressed():
	pass
