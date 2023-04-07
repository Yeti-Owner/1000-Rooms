extends Node3D

@export var NewPos: Vector3 := Vector3(1, 1, 1)
@export var TimeToMove: float := 2.0

@onready var tween := Tween.new()
@onready var Pos := self.global_transform.origin


func _ready():
	add_child(tween)

func _move():
	var _error = tween.interpolate_property(self, "position", Pos, NewPos, TimeToMove)
	var _error2 = tween.start()
