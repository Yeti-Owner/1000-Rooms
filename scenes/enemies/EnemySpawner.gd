extends Spatial

export(String, "Ghost", "Fairy", "Spike") var Enemy = "Ghost"
var scene
var Warning = 2

func _ready():
	match Enemy:
		"Ghost":
			scene = preload("res://scenes/enemies/GhostEnemy.tscn")
			$WarningPlayer.stream = load("res://assets/audio/scary/ghost1.ogg")
		"Fairy":
			scene = preload("res://scenes/enemies/FairyEnemy.tscn")
			$WarningPlayer.stream = load("res://assets/audio/scary/FairyBell.ogg")
		"Spike":
			scene = preload("res://scenes/enemies/Spike.tscn")
#	_summon()

func _summon():
	yield(get_tree(), "idle_frame")
	$WarningPlayer.play()
	$SummonTimer.wait_time = Warning
	$SummonTimer.start()

func _on_SummonTimer_timeout():
	$AnimationPlayer.play(Enemy)

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Ghost":
			var Ginstance = scene.instance()
			get_parent().add_child(Ginstance)
			Ginstance.global_transform.origin = $GhostPos.global_transform.origin
