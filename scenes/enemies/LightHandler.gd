extends Spatial

export(int, 2, 10) var Amount = 2
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
	print(str(Amount))
	if Amount <= 0:
		pass
