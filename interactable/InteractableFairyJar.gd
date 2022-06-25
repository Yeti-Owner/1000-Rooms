extends Interactable
var Released = false
var ReleasedText = "Press E to open the jar"
var ReleasedYet = 0
signal FairyReleased

func _ready():
	$AnimationPlayer.play("FairyRandomFly")

func get_interaction_text():
	return ReleasedText

func interact():
	_released()

func _released():
	if ReleasedYet:
		return
	else:
		$AnimationPlayer.stop()
		ReleasedText = "..."
		Released = 1
		emit_signal("FairyReleased")
		$AnimationPlayer.play("FairyEscape")
		ReleasedYet = 1

func _on_AnimationPlayer_animation_finished(_anim_name):
	if Released:
		pass
	else:
		$AnimationPlayer.play("FairyRandomFly")
		pass
