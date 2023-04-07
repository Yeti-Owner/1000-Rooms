extends Area3D

@export var OneShot: bool = true
signal PlayerDetected

func _on_Sensor_area_entered(area):
	if area.name == "PlayerArea":
		emit_signal("PlayerDetected")
		if OneShot: self.queue_free()
