extends Spatial

onready var fader = $Fader
onready var Narrator = $Narrator
onready var _room = self.filename
var RNG
var RNG2

func _ready():
	randomize()
	SaveGame.game_data.CurrentRoom = _room
	fader._fade_in()
	_check_room()
	_add_objs()
	_enable_spikes()
	SaveGame._update_presence()

func _check_room():
	pass

func _add_objs():
	for _i2 in $Objs.get_children():
		RNG2 = randi() % 3
		if RNG2 != 0:
			_i2.queue_free()

func _enable_spikes():
	for _i in $SpikeHolder.get_children():
		RNG = randi() % (int($SpikeHolder.get_child_count()) + 2)
		if RNG != 0:
			_i.queue_free()
