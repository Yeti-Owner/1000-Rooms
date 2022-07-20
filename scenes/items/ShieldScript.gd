extends Spatial

enum {
	NEUTRAL,
	SHIELD,
	TRANSITION
}
var state = NEUTRAL

var cooldown = false

onready var anim_player = $AnimationPlayer

func _ready():
	if SaveGame.game_data.EnabledShield == 0:
		self.queue_free()

func _process(_delta):
	if not cooldown:
		match state:
			NEUTRAL:
				if Input.is_action_just_pressed("primary"):
					_shield_up()
			SHIELD:
				if not Input.is_action_pressed("primary"):
					_shield_down()
					state = TRANSITION
			TRANSITION:
				$shakeTimer.stop()

func _shield_up():
	print("Shield up")
	anim_player.play("shield_up")

func _shield():
	print("Shielding")
	$shakeTimer.wait_time = 3
	$shakeTimer.start()

func _shield_down():
	print("Shield down")
	anim_player.play("shield_down")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "shield_up":
		_shield()
		state = SHIELD
	elif anim_name == "shield_down":
		state = NEUTRAL


func _on_shakeTimer_timeout():
	_shield_down()
	state = TRANSITION
	$cooldownTimer.wait_time = 10
	$cooldownTimer.start()
	cooldown = true

func _on_cooldownTimer_timeout():
	cooldown = false
