extends Control

var isActive = false

func _ready():
	pass

func _process(_delta):
	if isActive:
		pass

func _on_GamesBtn_pressed():
	print("Games")

func _on_OptionsBtn_pressed():
	print("Options")

func _on_ExitBtn_pressed():
	print("Exit")
