extends KinematicBody

onready var Player = get_node("/root/world/Fader/Player")

enum {
	IDLE,
	WANDERING,
	CHASING
}
var state = WANDERING

var speed = 0.038
var pLocation
var fLocation
var Mx
var My
var Mz

var v = 12
var RandomDir = Vector3(0, 0, 1)
var WanderSpeed = 0.01

func _ready():
	randomize()
	for i in v:
		i = i + 1
		get_node(str("RayCast" + str(i))).connect("Collided", self,"_collided")

func _collided():
	RandomDir = RandomDir.inverse()
#	RandomDir = RandomDir*-1
#	RandomDir.x = RandomDir.x*-1
#	RandomDir.y = RandomDir.y*-1
#	RandomDir.z = RandomDir.z*-1

func _process(_delta):
	match state:
		IDLE:
			$AnimationPlayer.play("Idle")
		WANDERING:
			$AnimationPlayer.stop()
			_wander()
		CHASING:
			$AnimationPlayer.stop()
			_move_to_player()

func _on_FairyVision_area_entered(area):
	if area.name == "PlayerArea":
		state = CHASING

func _wander():
	global_transform.origin += RandomDir.normalized() * WanderSpeed

func _move_to_player():
	pLocation = Player.global_transform.origin # Player pos
	fLocation = self.global_transform.origin # Fairy pos
	if abs(pLocation.distance_to(fLocation)) <= 0.499:
		return
	else:
		Mx = sign(pLocation.x - fLocation.x)
		My = sign(pLocation.y - fLocation.y) + 0.7
		Mz = sign(pLocation.z - fLocation.z)
		global_transform.origin += Vector3(Mx, My, Mz).normalized() * speed
#		self.global_transform.origin = Vector3(float(fLocation.x + (Mx*speed)), float(fLocation.y + (My*speed)), float(fLocation.z + (Mz*speed)))

func _on_FairyArea_area_entered(area):
	if area.name == "PlayerArea":
		SaveGame.game_data.PlayerHP -= 20


func _on_DirTimer_timeout():
	$DirTimer.wait_time = rand_range(1.0, 3.5)
	RandomDir = Vector3(randi() % 2 - 1, randi() % 2 - 1, randi() % 2 - 1)
	if RandomDir == Vector3(0, 0, 0):
		RandomDir = Vector3(0, 0, 1)
	$DirTimer.start()
