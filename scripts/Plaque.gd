extends Spatial

export var Text = ""
export(int) var FontSize = 50
onready var label := $PlaqueText
var LabelStyle := preload("res://resources/PlaqueFont.tres")

func _ready():
	scale.x = abs(scale.x)
	LabelStyle.size = FontSize
	label.text = Text
