extends KinematicBody

onready var Player = get_node("/root/world/Fader/Player")

enum {
	IDLE,
	BOUNCING,
	CHASING,
	MARCH
}
export(int) var state = 0
export(float) var MarchSpeed = 0.075

var speed = 7
var _dir
var _vel
var pLocation
var fLocation
var Mx
var Mz

var v = 12
var RandomDir = Vector3(0, 0, 1)
var BounceSpeed = 9.5

var Num = 1


func _change_state(STATE):
	state = STATE

func _ready():
	randomize()

func _physics_process(_delta):
	match state:
		IDLE:
			$AnimationPlayer.play("Idle")
		BOUNCING:
			_bounce()
		CHASING:
			_move_to_player()
		MARCH:
			_march()

func _on_FairyVision_area_entered(area):
	if area.name == "PlayerArea":
		state = CHASING

func _bounce():
	if is_on_floor() or is_on_ceiling() or is_on_wall():
		RandomDir = RandomDir*-1
	var _error = move_and_slide(RandomDir.normalized()*BounceSpeed, Vector3.UP)

func _move_to_player():
	pLocation = Player.global_transform.origin # Player pos
	fLocation = self.global_transform.origin # Fairy pos
	if abs(pLocation.distance_to(fLocation)) <= 0.499:
		return
	else:
		Mx = sign(pLocation.x - fLocation.x)
		Mz = sign(pLocation.z - fLocation.z)
		_dir = Vector3(Mx, 0, Mz) 
		_vel = _dir.normalized()*speed
		var _error = move_and_slide(_vel, Vector3.UP)

func _march():
	if get_parent().unit_offset == 1:
		Num = 0
	elif get_parent().unit_offset == 0:
		Num = 1
	
	if Num == 1:
		get_parent().offset += MarchSpeed
	elif Num == 0:
		get_parent().offset -= MarchSpeed


func _on_FairyArea_area_entered(area):
	pass
#	if area.name == "PlayerArea":
#		SaveGame.game_data.PlayerHP -= 20


func _on_DirTimer_timeout():
	$DirTimer.wait_time = rand_range(2.0, 5.0)
	RandomDir = Vector3(randi() % 2 - 1, randi() % 2 - 1, randi() % 2 - 1)
	if RandomDir == Vector3(0, 0, 0):
		RandomDir = Vector3(0, 0, 1)
	$DirTimer.start()


func _on_BellTimer_timeout():
	$FairyBell.pitch_scale = rand_range(0.9, 1.3)
	$FairyBell.play()
	$BellTimer.wait_time = rand_range(1.23, 4.1)
