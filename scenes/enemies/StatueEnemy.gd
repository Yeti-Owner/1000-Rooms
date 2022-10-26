extends KinematicBody

onready var Player := get_node("/root/SceneManager/GameScene/GameViewport/world/RoomItems/Player")
onready var nav := $NavigationAgent
onready var EyeL := $EyeL
onready var EyeR := $EyeR

enum STATE {
	IDLE,
	CHASING,
	STUNNED,
	SOLID
}
export(STATE) var NewState = STATE.CHASING
export(int, 3, 14, 1.0) var speed = 8

var state
var targetPos
var direction

func _ready():
	state = NewState
# warning-ignore:return_value_discarded
	SaveGame.connect("EnemyPassive", self, "_passive") 
	nav.set_target_location(Player.transform.origin)
	targetPos = nav.get_next_location()

func _physics_process(_delta):
	match state:
		STATE.IDLE:
			look_at(Player.get_translation(), Vector3.UP)
		STATE.CHASING:
			look_at(Player.get_translation(), Vector3.UP)
			EyeL.look_at(Player.get_translation(), Vector3.UP)
			EyeR.look_at(Player.get_translation(), Vector3.UP)
			if $Timer.is_stopped():
				$Timer.start()
			move_to_target()
		STATE.STUNNED:
			EyeL.look_at(Player.get_translation(), Vector3.UP)
			EyeR.look_at(Player.get_translation(), Vector3.UP)
		STATE.SOLID:
			pass

func move_to_target():
	direction = targetPos - self.transform.origin
	direction.y = 0.0
	direction = direction.normalized()
	var _error = move_and_slide(direction * speed, Vector3.UP)

func _passive():
	state = STATE.IDLE

func _on_Timer_timeout():
	nav.set_target_location(Player.transform.origin)
	targetPos = nav.get_next_location()

func _on_HitTimer_timeout():
	state = STATE.CHASING

func _on_StatueArea_area_entered(area):
	if area.name == "PlayerArea":
		if $HitTimer.is_stopped():
			SaveGame.DeathReason = "statue"
			state = STATE.IDLE
			SaveGame.game_data.PlayerHP -= 31
			$HitTimer.start()
	if area.is_in_group("Light"):
		state = STATE.STUNNED

func _on_StatueArea_area_exited(area):
	if area.is_in_group("Light") and ($StatueArea.get_overlapping_areas().size() == 0):
		state = STATE.CHASING
