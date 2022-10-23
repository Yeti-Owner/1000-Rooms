extends Spatial

var Pos
var SpawnPos
var num:int

func _ready():
	randomize()
	
	if get_parent().get_parent().AllowEnemy == true:
		num = randi() % 5
		if num == 0:
			num = 1
		elif num == 3:
			num = 0
			print("0 spawned")
		else:
			num = 2
		
		Pos = get_children()
		for i in (get_child_count() - num):
			Pos.pop_at(randi() % Pos.size()).queue_free()
		
		yield(get_tree(), "idle_frame")
		
		_summon_statue()

func _summon_statue():
	if get_parent().get_parent().AllowEnemy == true:
		if num == 1:
			SpawnPos = get_child(0).global_transform.origin
			var _s = load("res://scenes/enemies/StatueEnemy.tscn")
			var s = _s.instance()
			get_parent().add_child(s)
			s.global_transform.origin = SpawnPos
		elif num == 2:
			SpawnPos = get_child(0).global_transform.origin
			var _s = load("res://scenes/enemies/StatueEnemy.tscn")
			var s = _s.instance()
			get_parent().add_child(s)
			s.global_transform.origin = SpawnPos
			
			var SpawnPos2 = get_child(1).global_transform.origin
			var _s2 = load("res://scenes/enemies/StatueEnemy.tscn")
			var s2 = _s2.instance()
			get_parent().add_child(s2)
			s2.global_transform.origin = SpawnPos2
