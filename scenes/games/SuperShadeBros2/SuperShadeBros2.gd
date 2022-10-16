extends Node2D

onready var Player = $ShadeBro

var SpawnLoc = Vector2(2, -32)
var level:int = 1 setget _next_level
var Score = 0
var Lives = 3
var dead = false

func _process(_delta):
	$CanvasLayer/Control/Coins.text = str("Score: " + str(Score) + str(" "))
	$CanvasLayer/Control/Lives.text = str(" Lives: " + str(Lives))

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"):
		$CanvasLayer/Control/Popup.visible = true
		get_tree().paused = true
	
	if Lives <= 0 and dead == false:
		_lose()
		dead = true

func _on_ResumeBtn_pressed():
	$CanvasLayer/Control/Popup.visible = false
	get_tree().paused = false

func _on_QuitBtn_pressed():
	_quit()

func _quit():
	var scene = load("res://scenes/games/Menu.tscn")
	yield(get_tree(), "idle_frame")
	var Game = scene.instance()
	get_parent().add_child(Game)
	Game._active()
	self.queue_free()

func _lose():
	# Hide GUI
	$CanvasLayer/Control/Coins.visible = false
	$CanvasLayer/Control/Lives.visible = false
	
	# Loss popup
	$CanvasLayer/Control/Loss/Stats.text = str("You died with a score of: " + str(Score))
	$CanvasLayer/Control/Loss.visible = true
	
	# Timer to quit game
	$CanvasLayer/Control/Loss/RestartTimer.start()
	Player.EnabledMovement = false

func _next_level(NewLevel):
	# set lives to 3 at least
	if Lives < 3: Lives = 3
	
	if NewLevel == 3:
		_quit()
	
	# Remove old level
	get_node("TileMap" + str(level)).queue_free()
	
	# Add Next level
	var l = load("res://scenes/games/SuperShadeBros2/Level" + str(NewLevel) + ".tscn")
	var _l = l.instance()
	self.add_child(_l)
	
	# Re-add Player
	var p = load("res://scenes/games/SuperShadeBros2/ShadeBro.tscn")
	var _p = p.instance()
	self.add_child(_p)
	_p.position = SpawnLoc
	
	level = NewLevel

func _on_RestartTimer_timeout():
	_quit()
