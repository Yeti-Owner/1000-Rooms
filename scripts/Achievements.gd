extends Popup

onready var Renderer = get_node("ViewportContainer/Viewport/AchievementRenderer")

#func _ready():
#	pass

#func _process(delta):
#	pass

func _on_CloseBtn_pressed():
	self.visible = false

func _on_LeftBtn_pressed():
	Renderer.CameraStage -= 1

func _on_RightBtn_pressed():
	Renderer.CameraStage += 1
