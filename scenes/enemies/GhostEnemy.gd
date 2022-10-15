extends KinematicBody

export var speed = 4

var GhostFx = ["res://assets/audio/scary/ghost1.ogg", "res://assets/audio/scary/ghost2.ogg", "res://assets/audio/scary/ghost3.ogg"]
var EnabledChasing = 1
var targetPos
var direction

onready var nav = get_node("NavigationAgent")
onready var target = get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player")

func _ready():
	$SoundTimer.start()
	randomize()
# warning-ignore:return_value_discarded
	SaveGame.connect("EnemyPassive", self, "_passive")
	nav.set_target_location(target.transform.origin)
	targetPos = nav.get_next_location()

func _physics_process(_delta):
	look_at(target.get_translation(), Vector3.UP)
	if EnabledChasing:
		if $Timer.is_stopped():
			$Timer.start()
		move_to_target()

func move_to_target():
	direction = targetPos - self.transform.origin
	direction.y = 0.0
	direction = direction.normalized()
	var _error = move_and_slide(direction * speed, Vector3.UP)

func _on_Timer_timeout():
	nav.set_target_location(target.transform.origin)
	targetPos = nav.get_next_location()

func _on_EnemyArea_area_entered(area):
	if area.name == "PlayerArea":
		EnabledChasing = 0
		$stun_timer.start()

func _on_stun_timer_timeout():
	EnabledChasing = 1

func _on_SoundTimer_timeout():
	$AudioStreamPlayer3D.stream = load(GhostFx [randi() % GhostFx.size()])
	$AudioStreamPlayer3D.play()

func _on_AudioStreamPlayer3D_finished():
	var SoundTime = randi() % 3 + 1
	$SoundTimer.set_wait_time(SoundTime)
	$SoundTimer.start()

func _passive():
	EnabledChasing = 0
