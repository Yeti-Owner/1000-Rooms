extends Spatial
var Prompt = 0

func _ready():
	$CustomFader/PromptText.visible = false
	$IntroAnim.play("Drag")
	Settingsholder.save_data.Intro = 1

func _on_IntroAnim_animation_finished(anim_name):
	match anim_name:
		"Drag":
			$CustomFader/PromptText.visible = true
			Prompt = 1
		"Intro":
			$CustomFader/PromptText.visible = true
			$CustomFader/PromptText.text = "Hurry! Press E to enter"
			Prompt = 2
		"Enter":
			var _error = get_tree().change_scene("res://scenes/StartMenuV2.tscn")
		"Blink":
			$IntroAnim.play("Intro")

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		match Prompt:
			0:
				return
			1:
				$CustomFader/PromptText.visible = false
				$IntroAnim.play("Blink")
				Prompt = 0
			2:
				$CustomFader/PromptText.visible = false
				$IntroAnim.play("Enter")
				Prompt = 0
			3:
				pass
