extends Node2D

var SpawnLoc = Vector2(2, -32)
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
		$ShadeBro.position = SpawnLoc


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
