extends KinematicBody

onready var Player = get_node("/root/world/Fader/Player")


enum {
	IDLE,
	WANDERING,
	CHASING
}
export(int) var state = 0

var speed = 8
var _dir
var _vel
var pLocation
var fLocation
var Mx
var My
var Mz

var v = 12
var RandomDir = Vector3(0, 0, 1)
var WanderSpeed = 9.5

func _change_state(STATE):
	state = STATE

func _ready():
	randomize()

func _process(_delta):
	match state:
		IDLE:
			$AnimationPlayer.play("Idle")
		WANDERING:
			_wander()
		CHASING:
			_move_to_player()

func _on_FairyVision_area_entered(area):
	if area.name == "PlayerArea":
		state = CHASING

func _wander():
	if is_on_floor() or is_on_ceiling() or is_on_wall():
		RandomDir = RandomDir*-1
	var _error = move_and_slide(RandomDir.normalized()*WanderSpeed, Vector3.UP)

func _move_to_player():
	pLocation = Player.global_transform.origin # Player pos
	fLocation = self.global_transform.origin # Fairy pos
	if abs(pLocation.distance_to(fLocation)) <= 0.499:
		return
	else:
		Mx = sign(pLocation.x - fLocation.x)
		My = sign(pLocation.y - fLocation.y)
		Mz = sign(pLocation.z - fLocation.z)
		_dir = Vector3(Mx, My+0.5, Mz)
		_vel = _dir.normalized()*speed
		var _error = move_and_slide(_vel, Vector3.UP)
#		global_transform.origin += Vector3(Mx, My, Mz).normalized() * speed
#		self.global_transform.origin = Vector3(float(fLocation.x + (Mx*speed)), float(fLocation.y + (My*speed)), float(fLocation.z + (Mz*speed)))

func _on_FairyArea_area_entered(area):
	if area.name == "PlayerArea":
		SaveGame.game_data.PlayerHP -= 20


func _on_DirTimer_timeout():
	$DirTimer.wait_time = rand_range(2.0, 5.0)
	RandomDir = Vector3(randi() % 2 - 1, randi() % 2 - 1, randi() % 2 - 1)
	if RandomDir == Vector3(0, 0, 0):
		RandomDir = Vector3(0, 0, 1)
	$DirTimer.start()
