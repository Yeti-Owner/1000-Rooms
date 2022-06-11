extends KinematicBody

export var speed = 5

var path = []
var cur_path_idx = 0
var velocity = Vector3.ZERO
var threshold = 0.01
var old_speed
var dir

onready var nav = get_parent()
onready var target = get_node("/root/world/Fader/Player")


func _process(delta):
	look_at(target.get_translation(), Vector3.UP)
	if path.size() > 0:
		move_to_target()

func move_to_target():
	if cur_path_idx >= path.size():
		return
	
	if global_transform.origin.distance_to(path[cur_path_idx]) < threshold:
		cur_path_idx += 1
		
	else:
		var direction = path[cur_path_idx] - global_transform.origin
		velocity = direction.normalized() * speed
		move_and_slide(velocity, Vector3.UP)


func get_target_path(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	cur_path_idx = 0

func _on_Timer_timeout():
	get_target_path(target.global_transform.origin)


func _on_EnemyArea_area_entered(area):
	if area.name == "PlayerArea":
		old_speed = speed
		speed = 0
		$stun_timer.start()


func _on_stun_timer_timeout():
	speed = old_speed
