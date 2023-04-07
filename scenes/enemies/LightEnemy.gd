extends Interactable

signal LightCollected

var RandColor: Color

func _ready():
# warning-ignore:return_value_discarded
	connect("LightCollected",Callable(get_parent(),"_light_collected"))
	RandColor = Color(randf(), randf(), randf(), 1)
#	$MeshInstance3D.set_material_override()
	$MeshInstance3D.material_override = $MeshInstance3D.material_override.duplicate()
	$MeshInstance3D.material_override.albedo_color = RandColor
	$OmniLight3D.light_color = RandColor

func get_interaction_text():
	return "Press E to touch"

func interact():
	self.queue_free()
	emit_signal("LightCollected")
