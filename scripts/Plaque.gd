extends Spatial

export var Text = ""
export(int) var FontSize = 50
onready var label = $view/PlaqueText
var LabelStyle := preload("res://resources/PlaqueFont.tres")

func _ready():
	LabelStyle.size = FontSize
	label.text = Text
