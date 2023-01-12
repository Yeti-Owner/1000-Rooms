extends AudioStreamPlayer
var ScareList := ["res://assets/audio/scary/AHHHH1.ogg","res://assets/audio/scary/AHHHH2.ogg","res://assets/audio/scary/AHHHH3.ogg","res://assets/audio/scary/Bass1.ogg"]

func _ready():
	randomize()

func _scare_sound():
	self.stream = load(ScareList [randi() % ScareList.size()])
	play()
