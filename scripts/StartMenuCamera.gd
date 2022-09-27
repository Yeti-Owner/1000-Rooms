extends Camera

var RNG
var Last
#var pos1 = Vector3(-23.686, 2.086, 18.111)
#var pos2 = Vector3(-5.18, 2.086, 11.7)
#var pos3 = Vector3(17.028, 0.775, 11.7)
#var pos4 = Vector3(53.209, 1.569, 29.826)
onready var Anim = $AnimationPlayer
#onready var fader = get_parent()
onready var timer = get_parent().get_node("Timer")


func _ready():
	SceneManager.HudMode = "mainmenu"
	randomize()
	_change_cam()
	timer.start()
#	fader.connect("fade_finished", self, "on_fade_finished")

func _on_AnimationPlayer_animation_finished(_anim_name):
	_change_cam()

func _change_cam():
	RNG = randi() % 4
	if RNG == Last:
		_change_cam()
	elif RNG == 0:
#		timer.start()
#		self.set_translation(pos1)
		Anim.play("loc1")
		Last = RNG
	elif RNG == 1:
#		timer.start()
#		self.set_translation(pos2)
		Anim.play("loc2")
		Last = RNG
	elif RNG == 2:
#		timer.start()
#		self.set_translation(pos3)
		Anim.play("loc3")
		Last = RNG
	elif RNG == 3:
#		timer.start()
#		self.set_translation(pos4)
		Anim.play("loc4")
		Last = RNG

func _on_Timer_timeout():
#	fader._fade_out()
	timer.start()

#func on_fade_finished():
#	fader._fade_in()
#	timer.start()
