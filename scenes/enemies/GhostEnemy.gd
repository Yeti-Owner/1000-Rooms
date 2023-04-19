extends CharacterBody3D

@export var speed := 4
@onready var nav := get_node("NavigationAgent3D")
@onready var target := get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player")

var GhostFx := ["res://assets/audio/scary/ghost1.ogg", "res://assets/audio/scary/ghost2.ogg", "res://assets/audio/scary/ghost3.ogg"]
var EnabledChasing := true
var targetPos
var direction

func _ready():
	$SoundTimer.start()
	randomize()
# warning-ignore:return_value_discarded
	SaveGame.connect("EnemyPassive",Callable(self,"_passive"))
	nav.set_target_position(target.transform.origin)
	targetPos = nav.get_next_path_position()

func _physics_process(_delta):
	look_at(target.get_position(), Vector3.UP)
	if EnabledChasing:
		if $Timer.is_stopped():
			$Timer.start()
		move_to_target()

func move_to_target():
	direction = targetPos - self.transform.origin
	direction.y = 0.0
	direction = direction.normalized()
	set_velocity(direction * speed)
	set_up_direction(Vector3.UP)
	move_and_slide()
	var _error := velocity

func _on_Timer_timeout():
	nav.set_target_position(target.transform.origin)
	targetPos = nav.get_next_path_position()

func _on_EnemyArea_area_entered(area):
	if area.name == "PlayerArea":
		EnabledChasing = false
		$stun_timer.start()

func _on_stun_timer_timeout():
	EnabledChasing = true

func _on_SoundTimer_timeout():
	$AudioStreamPlayer3D.stream = load(GhostFx [randi() % GhostFx.size()])
	$AudioStreamPlayer3D.play()

func _on_AudioStreamPlayer3D_finished():
	var SoundTime = randi() % 3 + 1
	$SoundTimer.set_wait_time(SoundTime)
	$SoundTimer.start()

func _passive():
	EnabledChasing = false
