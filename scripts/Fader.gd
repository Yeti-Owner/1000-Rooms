extends ColorRect

onready var AnimPlayer = $AnimationPlayer

signal fade_finished

func _ready():
	AnimPlayer.connect("animation_finished", self, "on_animation_finished")


func _fade_in():
	AnimPlayer.play("fade_in")

func _fade_out():
	AnimPlayer.play("fade_out")


func on_animation_finished(_name):
	emit_signal("fade_finished")
