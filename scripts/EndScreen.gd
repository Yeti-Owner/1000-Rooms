extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Button_pressed():
	OS.shell_open("https://forms.gle/FtncNqYqHXxhzjqg7")
