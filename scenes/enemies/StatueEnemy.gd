extends CharacterBody3D

@onready var Player := get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player")
@onready var nav := $NavigationAgent3D
@onready var EyeL := $EyeL
@onready var EyeR := $EyeR

enum STATE {
	IDLE,
	CHASING,
	STUNNED,
	SOLID
}
@export var NewState: STATE := STATE.CHASING
@export var speed := 8 # (int, 3, 14, 1.0)

var state
var targetPos
var direction
var IsStunned := false

func _ready():
	state = NewState
# warning-ignore:return_value_discarded
	SaveGame.connect("EnemyPassive",Callable(self,"_passive")) 
	nav.set_target_location(Player.transform.origin)
	targetPos = nav.get_next_location()

func _physics_process(_delta):
	match state:
		STATE.IDLE:
			look_at(Player.get_position(), Vector3.UP)
		STATE.CHASING:
			look_at(Player.get_position(), Vector3.UP)
			EyeL.look_at(Player.get_position(), Vector3.UP)
			EyeR.look_at(Player.get_position(), Vector3.UP)
			if $Timer.is_stopped():
				$Timer.start()
			move_to_target()
		STATE.STUNNED:
			EyeL.look_at(Player.get_position(), Vector3.UP)
			EyeR.look_at(Player.get_position(), Vector3.UP)
		STATE.SOLID:
			pass

func move_to_target():
	direction = targetPos - self.transform.origin
	direction.y = 0.0
	direction = direction.normalized()
	set_velocity(direction * speed)
	set_up_direction(Vector3.UP)
	move_and_slide()
	var _error := velocity

func _passive():
	state = STATE.IDLE

func _on_Timer_timeout():
	nav.set_target_location(Player.transform.origin)
	targetPos = nav.get_next_location()

func _on_HitTimer_timeout():
	IsStunned = false
	state = STATE.CHASING

func _stun():
	IsStunned = true
	state = STATE.IDLE
	$HitTimer.start()

func _on_StatueArea_area_entered(area):
	if area.is_in_group("Light3D"):
		state = STATE.STUNNED

func _on_StatueArea_area_exited(area):
	if area.is_in_group("Light3D") and ($StatueArea.get_overlapping_areas().size() == 0):
		state = STATE.CHASING
