extends Node2D

var SpawnLoc = Vector2(2, -32)
var level:int = 1 setget _next_level
var Score = 0
var Lives = 3

func _process(_delta):
	$CanvasLayer/Control/Coins.text = str("Score: " + str(Score) + str(" "))
	$CanvasLayer/Control/Lives.text = str(" Lives: " + str(Lives))

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"):
		$CanvasLayer/Control/Popup.visible = true
		get_tree().paused = true
	
	if Lives <= 0:
		_lose()

func _on_ResumeBtn_pressed():
	$CanvasLayer/Control/Popup.visible = false
	get_tree().paused = false

func _on_QuitBtn_pressed():
	var scene = load("res://scenes/games/Menu.tscn")
	yield(get_tree(), "idle_frame")
	var Game = scene.instance()
	get_parent().add_child(Game)
	Game._active()
	self.queue_free()

func _lose():
	$CanvasLayer/Control/Loss/Stats.text = str("You died with a score of: " + Score)
	$CanvasLayer/Control/Loss.visible = true
	

func _next_level(NewLevel):
	# set lives to 3 at least
	if Lives < 3:
		Lives = 3
	
	# Remove old level
	get_node("TileMap" + str(level)).queue_free()
	
	# Add Next level
	var l = load("res://scenes/games/SuperShadeBros2/Level" + str(NewLevel) + ".tscn")
	var _l = l.instance()
	self.add_child(_l)
	
	# Reset Player
	
	
	level = NewLevel


func _on_RestartTimer_timeout():
	pass # Replace with function body.
