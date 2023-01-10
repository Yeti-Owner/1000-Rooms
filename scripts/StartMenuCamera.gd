extends Camera

export(Environment) var EnvironmentUsed

onready var Anim := $AnimationPlayer
onready var timer := get_parent().get_node("Timer")

var Last:int = 1

func _ready():
	SceneManager.GameScene.world.environment = EnvironmentUsed
	SceneManager.HudMode = "mainmenu"
	randomize()
	_change_cam()
	timer.start()

func _on_AnimationPlayer_animation_finished(_anim_name):
	_change_cam()

func _change_cam():
	var RNG := randi() % 4
	if RNG == Last:
		_change_cam()
	else:
		Last = RNG
		var AnimName = str("loc" + str(RNG + 1))
		Anim.play(AnimName)

func _on_Timer_timeout():
	timer.start()

