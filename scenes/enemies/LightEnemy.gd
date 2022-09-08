extends Interactable

signal LightCollected

var RandColor: Color

func _ready():
# warning-ignore:return_value_discarded
	connect("LightCollected", get_parent(), "_light_collected")
	RandColor = Color(randf(), randf(), randf(), 1)
#	$MeshInstance.set_material_override()
	$MeshInstance.material_override = $MeshInstance.material_override.duplicate()
	$MeshInstance.material_override.albedo_color = RandColor
	$OmniLight.light_color = RandColor

func get_interaction_text():
	return "Press E to touch"

func interact():
	emit_signal("LightCollected")
