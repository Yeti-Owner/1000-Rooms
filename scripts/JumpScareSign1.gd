extends StaticBody
var RNG
var HasNotJumpScared = 1

func _ready():
	randomize()
	self.set_visible(false)
	get_node("CollisionShape").disabled = true
	get_node("CollisionShape2").disabled = true

func _jumpscare():
	self.set_visible(true)
	get_node("CollisionShape").set_deferred("disabled",  false)
	get_node("CollisionShape2").set_deferred("disabled",  false)
	HasNotJumpScared = !HasNotJumpScared
	SaveGame.game_data.JumpScareAmt = 0
	get_parent().get_node("ScarePlayer")._scare_sound()
	

func _on_Area_area_entered(area):
	if area.name == "PlayerArea" && HasNotJumpScared:
		RNG = randi() % 40 + 1
		if RNG == 1:
			_jumpscare()
		elif int(SaveGame.game_data.JumpScareAmt) == 30:
			_jumpscare()
		else:
			SaveGame.game_data.JumpScareAmt += 1
			queue_free()
