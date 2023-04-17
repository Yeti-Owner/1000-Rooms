extends StaticBody3D
var RNG:int
var HasNotJumpScared:bool = 1

func _ready():
	randomize()
	self.set_visible(false)
	get_node("CollisionShape3D").disabled = true
	get_node("CollisionShape3D2").disabled = true

func _on_Area_area_entered(area):
	if area.name == "PlayerArea" && HasNotJumpScared:
		RNG = randi() % 50 + 1
		if RNG == 1:
			_jumpscare()
		elif int(SaveGame.game_data.JumpScareAmt) == 40:
			_jumpscare()
		else:
			SaveGame.game_data.JumpScareAmt += 1
			queue_free()

func _jumpscare():
	self.set_visible(true)
	get_node("CollisionShape3D").set_deferred("disabled",  false)
	get_node("CollisionShape3D2").set_deferred("disabled",  false)
	HasNotJumpScared = !HasNotJumpScared
	SaveGame.game_data.JumpScareAmt = 0
	get_parent().get_node("ScarePlayer")._scare_sound()
