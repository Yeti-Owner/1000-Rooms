extends Node3D

@export var Text = ""
@export var FontSize: int = 50
@onready var label := $PlaqueText
var LabelStyle := preload("res://resources/PlaqueFont.tres")

func _ready():
	scale.x = abs(scale.x)
#	LabelStyle.size = FontSize
	label.text = Text
