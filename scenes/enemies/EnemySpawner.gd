extends Node3D

@export var Enemy := "Ghost" # (String, "Ghost", "Fairy", "Spike")
var scene:PackedScene
var Warning:int = 2

func _ready():
	match Enemy:
		"Ghost":
			scene = preload("res://scenes/enemies/GhostEnemy.tscn")
			$WarningPlayer.stream = load("res://assets/audio/scary/ghost1.ogg")

func _summon():
	await get_tree().idle_frame
	$WarningPlayer.play()
	$SummonTimer.wait_time = Warning
	$SummonTimer.start()

func _on_SummonTimer_timeout():
	$AnimationPlayer.play(Enemy)

func _on_AnimationPlayer_animation_finished(_anim_name):
	var Ginstance := scene.instantiate()
	get_parent().add_child(Ginstance)
	Ginstance.global_transform.origin = $GhostPos.global_transform.origin
#	match _anim_name:
#		"Ghost":
#			var Ginstance = scene.instantiate()
#			get_parent().add_child(Ginstance)
#			Ginstance.global_transform.origin = $GhostPos.global_transform.origin
