extends Spatial

var triggered = false
onready var player = get_node("/root/world/Fader/Player")

func _ready():
	$Spike/StaticBody/CollisionShape.disabled = true

func _process(_delta):
	if triggered == false:
		look_at(player.global_transform.origin, Vector3.UP)

func _triggered():
	$Spike.visible = true
	$TriggeredTween.interpolate_property($Spike, "translation", $Spike.translation, Vector3(0,0,0), 1.5, 0)
	$TriggeredTween.start()


func _on_SpikeArea_area_entered(area):
	if area.name == "PlayerArea":
		$Spike/StaticBody/CollisionShape.set_deferred("disabled", false)
		triggered = true
		get_parent().Chase = false
		$TriggeredTween.stop_all()
	elif area.name == "ShieldArea":
		$Spike/StaticBody/CollisionShape.set_deferred("disabled", false)
		triggered = true
		get_parent().Chase = false
		$TriggeredTween.stop_all()

func _on_TriggeredTween_tween_completed(object, key):
	triggered = true
	get_parent().Chase = false
	$Spike/StaticBody/CollisionShape.set_deferred("disabled", false)
