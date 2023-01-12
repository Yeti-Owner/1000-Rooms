extends Node2D

var speed : float = 150
var TreePath := "res://scenes/games/GhostRun/ObstacleTree.tscn"
var CloudPath := "res://scenes/games/GhostRun/ObstacleCloud.tscn"

var Toffset1 := 1
var Toffset2 := 3
var Coffset1 := 1.5
var Coffset2 := 4.5

func _ready():
	Engine.set_target_fps(60)

func _physics_process(_delta):
	$TileMap.position.x = $Player.position.x
	$TileMap/TreeSpawn.position.x = $Player.position.x + 1000
	$TileMap/CloudSpawn.position.x = $Player.position.x + 1000
	$BG.position = $Player.position

func _on_SpawnTimer_timeout():
	var o = load(TreePath).instance()
	o.position = $TileMap/TreeSpawn.position
	$Spawns.add_child(o)
	$SpawnTimer.wait_time = rand_range(Toffset1, Toffset2)
	$SpawnTimer.start()

func _on_SpawnTimer2_timeout():
	var c = load(CloudPath).instance()
	c.position = $TileMap/CloudSpawn.position
	$Spawns.add_child(c)
	$SpawnTimer2.wait_time = rand_range(Coffset1, Coffset2)
	$SpawnTimer2.start()

func _on_ScalingTimer_timeout():
	$Player.speed += 5
	Toffset1 += 0.05
	Toffset2 += 0.05
	Coffset1 += 0.05
	Coffset2 += 0.05
