extends RayCast

signal Collided

func _process(_delta):
	if self.is_colliding():
		emit_signal("Collided")
