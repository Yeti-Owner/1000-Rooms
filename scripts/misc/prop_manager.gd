extends Node3D

const ignore_list:Array = ["Ladder", "Vent"]

func _ready():
	randomize()
	
	for child in get_children():
		# 1 in 3 chance to keep
		if (randi() % 3) != 0:
			child.queue_free()
		elif child.name.rstrip("0123456789") not in ignore_list:
			# slightly "wiggle" the prop position
			var wiggle := Vector3(randf_range(-0.2, 0.2), 0, randf_range(-0.2, 0.2))
			child.position += wiggle
			
			# slightly "tweak" the prop rotation
			var tweak := randf_range(-25, 25)
			child.rotation.y += tweak
