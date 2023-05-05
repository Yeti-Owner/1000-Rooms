extends Area

export(bool) var OneShot = true
signal PlayerDetected

func _on_Sensor_area_entered(area):
	if area.name == "PlayerArea":
		emit_signal("PlayerDetected")
		if OneShot: self.queue_free()
