extends AudioStreamPlayer
var ScareList = ["res://assets/audio/scary/AHHHH1.wav","res://assets/audio/scary/AHHHH2.wav","res://assets/audio/scary/AHHHH3.wav","res://assets/audio/scary/Bass1.wav"]

func _ready():
	randomize()

func _scare_sound():
	self.stream = load(ScareList [randi() % ScareList.size()])
	play()
