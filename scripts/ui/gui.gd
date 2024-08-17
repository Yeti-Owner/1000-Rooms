extends CanvasLayer

@onready var crosshair = $Center/Crosshair
@onready var interact_label = $InteractLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.interaction.connect(_set_interaction)

func _set_interaction(icon, text):
	if icon == null:
		crosshair.set_visible(false)
	else:
		crosshair.texture = load(icon)
		crosshair.set_visible(true)
	if text == null:
		interact_label.set_text("")
		interact_label.set_visible(false)
	else:
		interact_label.set_text(str("" + text))
		interact_label.set_visible(true)
