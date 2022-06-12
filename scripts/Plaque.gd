extends Spatial

export var Text = ""
onready var label = $view/PlaqueText

func _ready():
	label.text = Text
