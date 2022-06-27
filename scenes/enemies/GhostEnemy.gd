extends KinematicBody

export var speed = 5

var GhostFx = ["res://assets/audio/scary/ghost1.ogg", "res://assets/audio/scary/ghost2.ogg", "res://assets/audio/scary/ghost3.ogg"]
var path = []
var cur_path_idx = 0
var velocity = Vector3.ZERO
var threshold = 0.1
var old_speed
var dir
var EnabledChasing = 1

onready var nav = get_parent()
onready var target = get_node("/root/world/Fader/Player")

func _ready():
	$SoundTimer.start()
	randomize()

func _process(_delta):
	look_at(target.get_translation(), Vector3.UP)
	if path.size() > 0 && EnabledChasing:
		move_to_target()

func move_to_target():
	if cur_path_idx >= path.size():
		return
	
	if global_transform.origin.distance_to(path[cur_path_idx]) < threshold:
		cur_path_idx += 1
		
	else:
		var direction = path[cur_path_idx] - global_transform.origin
		velocity = direction.normalized() * speed
		var _error = move_and_slide(velocity, Vector3.UP)


func get_target_path(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	cur_path_idx = 0

func _on_Timer_timeout():
	get_target_path(target.global_transform.origin)


func _on_EnemyArea_area_entered(area):
	if area.name == "PlayerArea":
		SaveGame.game_data.PlayerHP -= 15
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
