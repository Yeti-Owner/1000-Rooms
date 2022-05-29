extends StaticBody
var RNG
var HasNotJumpScared = 1

func _ready():
	randomize()
	self.set_visible(false)
	get_node("CollisionShape").disabled = true

func _jumpscare():
	self.set_visible(true)
	get_node("CollisionShape").set_deferred("disabled",  false)
	HasNotJumpScared = !HasNotJumpScared
	Settingsholder.JumpScareAmt = 0
	# play scary sound ig (placeholder)

func _on_Area_area_entered(area):
	if area.name == "PlayerArea" && HasNotJumpScared:
		RNG = randi() % 10 + 1
		if RNG == 1:
			_jumpscare()
		elif int(Settingsholder.JumpScareAmt) == 10:
			_jumpscare()
		else:
			Settingsholder.JumpScareAmt += 1
			queue_free()
