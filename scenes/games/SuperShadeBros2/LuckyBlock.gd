extends Node2D

@export var Reward := "Coin" # (String, "Coin", "Life", "C")
@export var NumBumps: int := 1

func _on_Area2D_area_entered(area):
	if area.name == "ShadeArea" and NumBumps > 0:
		if not $AnimationPlayer.is_playing():
			match Reward:
				"Coin":
					$AnimationPlayer.play(Reward)
					get_parent().get_parent().Score += 10
					NumBumps -= 1
	if NumBumps <= 0: $Sprite2D.texture = load("res://scenes/games/SuperShadeBros2/EmptyLuckyBlock.png")
