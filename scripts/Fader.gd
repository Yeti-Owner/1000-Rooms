extends ColorRect

onready var AnimPlayer = $AnimationPlayer

signal fade_finished

func _ready():
	self.visible = true
	AnimPlayer.connect("animation_finished", self, "on_animation_finished")


func _fade_in():
	self.visible = true
	AnimPlayer.play("fade_in")

func _fade_out():
	self.visible = true
	AnimPlayer.play("fade_out")


func on_animation_finished(_name):
	emit_signal("fade_finished")
	self.visible = false
