extends AudioStreamPlayer
var ClickList := ["res://assets/audio/click/click.ogg","res://assets/audio/click/click2.ogg","res://assets/audio/click/click3.ogg","res://assets/audio/click/click4.ogg"]

func _ready():
	randomize()

func _click_sound():
	self.stream = load(ClickList [randi() % ClickList.size()])
	play()
