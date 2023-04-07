extends Node3D

@export var Amount := 2 # (int, 2, 15)
var Children

# warning-ignore:unused_signal
signal LightCollected

func _ready():
	randomize()
	# Choose which children to keep
	Children = get_children()
	for i in (get_child_count() - Amount):
		Children.pop_at(randi() % Children.size()).queue_free()

func _light_collected():
	Amount -= 1
	if Amount <= 0:
		get_parent()._lights_complete()
