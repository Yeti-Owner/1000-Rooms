extends CharacterBody3D

@onready var Player := get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player")

enum {
	IDLE,
	BOUNCING,
	CHASING,
	MARCH
}
@export var state: int := 0
@export var MarchSpeed: float := 0.075

var speed := 6
var _dir
var _vel
var pLocation
var fLocation
var Mx
var Mz

var v := 12
var RandomDir := Vector3(0, 0, 1)
var BounceSpeed := 9.5

var Num := 1


func _change_state(STATE):
	state = STATE

func _ready():
	randomize()
# warning-ignore:return_value_discarded
	SaveGame.connect("EnemyPassive",Callable(self,"_passive"))

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
	set_velocity(RandomDir.normalized()*BounceSpeed)
	set_up_direction(Vector3.UP)
	move_and_slide()
	var _error := velocity

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
		set_velocity(_vel)
		set_up_direction(Vector3.UP)
		move_and_slide()
		var _error := velocity

func _march():
	if get_parent().progress_ratio == 1:
		Num = 0
	elif get_parent().progress_ratio == 0:
		Num = 1
	
	if Num == 1:
		get_parent().offset += MarchSpeed
	elif Num == 0:
		get_parent().offset -= MarchSpeed

func _on_DirTimer_timeout():
	$DirTimer.wait_time = randf_range(2.0, 5.0)
	RandomDir = Vector3(randi() % 2 - 1, randi() % 2 - 1, randi() % 2 - 1)
	if RandomDir == Vector3(0, 0, 0):
		RandomDir = Vector3(0, 0, 1)
	$DirTimer.start()

func _on_BellTimer_timeout():
	$FairyBell.pitch_scale = randf_range(0.9, 1.3)
	if $FairyBell.is_playing() == false:
		$FairyBell.play()
		$BellTimer.wait_time = randf_range(1.23, 4.1)

func _passive():
	state = IDLE
