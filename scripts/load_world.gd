extends Spatial

onready var fader = $Fader

func _ready():
	fader._fade_in()
