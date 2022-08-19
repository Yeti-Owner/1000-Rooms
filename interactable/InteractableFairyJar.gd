extends Interactable
var ReleasedText = "Press E to mess with it"
var ReleasedYet = 0
#onready var loc = $Fairy.global_transform.origin
signal FairyReleased
var v = 20

func _ready():
	$AnimationPlayer.play("FairyRandomFly")

func get_interaction_text():
	return ReleasedText

func interact():
	_released()

func _process(_delta):
	if ReleasedYet:
		return
	else:
		var loc = $Fairy.global_transform.origin
		$Fairy.global_transform.origin = lerp(loc, Vector3(0, 1, -50.3), 0.025)
		if abs(loc.distance_to(Vector3(0, 1, -50.3))) <= 0.08:
			ReleasedYet = 1
			$Fairy.queue_free()
func _released():
	if ReleasedYet:
		return
	else:
		emit_signal("FairyReleased")
		$GlassSound.play()
		$GlassBreaking.emitting = true
		$AnimationPlayer.stop()
		$AnimationPlayer.queue_free()
		ReleasedText = "..."
		$Jar.visible = false
		$CrackedMesh.visible = true
		$Fairy.visible = false
