extends Spatial

export(Vector3) var NewPos := Vector3(1, 1, 1)
export(float) var TimeToMove := 2.0

onready var tween := Tween.new()
onready var Pos := self.global_transform.origin


func _ready():
	add_child(tween)

func _move():
	var _error = tween.interpolate_property(self, "translation", Pos, NewPos, TimeToMove)
	var _error2 = tween.start()
