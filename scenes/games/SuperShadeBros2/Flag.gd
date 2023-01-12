extends Node2D

var ShadeBro
var OldCamPos:Vector2

func _on_FlagArea_area_entered(area):
	if area.name == "ShadeArea":
		if area.global_position != $Position2D.global_position:
			ShadeBro = area.get_parent()
			$Tween.interpolate_property(ShadeBro, "global_position", ShadeBro.global_position, $Position2D.global_position, 1, 0)
			$Tween.interpolate_property(ShadeBro, "scale", ShadeBro.scale, Vector2(2,2), 1, 0)
			OldCamPos = ShadeBro.get_node("Camera2D").global_position
			$Tween.interpolate_property(ShadeBro.get_node("Camera2D"), "global_position", ShadeBro.get_node("Camera2D").global_position, $CamPos.global_position, 1, 0)
			$Tween.start()

func _on_Tween_tween_completed(_object, _key):
	ShadeBro.visible = false
	$AnimationPlayer.play("Finish")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Finish":
		$Timer.start()

func _on_Timer_timeout():
	ShadeBro.queue_free()
	get_parent().get_parent().level += 1
