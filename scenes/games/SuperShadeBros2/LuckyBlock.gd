extends Node2D

export(String, "Coin", "Life", "C") var Reward = "Coin"
export(int) var NumBumps = 1

func _on_Area2D_area_entered(area):
	if area.name == "ShadeArea" and NumBumps > 0:
		match Reward:
			"Coin":
				if not $AnimationPlayer.is_playing():
					$AnimationPlayer.play(Reward)
					get_parent().get_parent().Score += 10
					NumBumps -= 1
	if NumBumps <= 0:
		$Sprite.texture = load("res://scenes/games/SuperShadeBros2/EmptyLuckyBlock.png")
