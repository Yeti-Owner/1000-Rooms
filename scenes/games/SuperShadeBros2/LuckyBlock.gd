extends Node2D

export(String, "Coin", "Life", "C") var Reward = "Coin"
export(int) var NumBumps = 1

#func _ready():
#	pass


#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if area.name == "ShadeArea" and NumBumps > 0:
		match Reward:
			"Coin":
				$AnimationPlayer.play(Reward)
				get_parent().get_parent().Score += 10
		NumBumps -= 1
	if NumBumps <= 0:
		$Sprite.texture = load("res://scenes/games/SuperShadeBros2/EmptyLuckyBlock.png")
