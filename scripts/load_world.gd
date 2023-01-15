extends Spatial

export(bool) var EnemyAllowed = true
export(Environment) var EnvironmentUsed
export var room_event: Resource

onready var Narrator := $Narrator
onready var Objs := $Objs
onready var _room := self.filename
 
func _ready():
	randomize()
	SceneManager.GameScene.world.environment = EnvironmentUsed
	_add_objs()
	SaveGame.game_data.CurrentRoom = _room
	_room_event()
	SaveGame._update_presence()
	_summon_enemy()

func _room_event():
	if not room_event:
		return
	if (room_event.first_time) and (SaveGame.game_data[room_event.var_used] == 0):
		return
	if (room_event.on_number != -1) and (room_event.on_number != SaveGame.game_data.RoomNum):
		if room_event.table_remove:
			get_node(room_event.table_path).queue_free()
			return
		else:
			return
	if room_event.narrator_text.size() > 0: Narrator.messages = room_event.narrator_text
	EnemyAllowed = room_event.enemy_allowed
	if room_event.var_used != null:
		SaveGame.game_data[room_event.var_used] = 0

func _add_objs():
	for _i in Objs.get_children():
		var RNG := randi() % 5
		if RNG == 0:
			_i.visible = true
		else:
			_i.queue_free()

func _summon_enemy():
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	if EnemyAllowed:
		var RNG := randi() % 5
		if RNG == 0 or SaveGame.isChased > 0:
			get_node("NavMesh/EnemySpawner")._summon()
			if SaveGame.isChased == 0:
				SaveGame.isChased = 5
			else:
				SaveGame.isChased -= 1
