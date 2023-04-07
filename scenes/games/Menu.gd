extends Control

var Hidden:bool
@onready var tween := $MenuTween

func _ready():
	$MarginContainer.visible = false

func _active():
	await get_tree().idle_frame
	$GamesHider.color.a = 1
	$GamesHider.visible = true
	Hidden = true
	$Hider.color.a = 0
	$MarginContainer.visible = true
	tween.interpolate_property($MarginContainer/VBoxContainer/CenterContainer, "position", Vector2(0,-360), Vector2(0,0), 2, 9)
	tween.interpolate_property($MarginContainer/VBoxContainer/VBoxContainer, "position", Vector2(-1260,344), Vector2(0,344), 2.5, 2)
	tween.start()

func _on_GamesBtn_pressed():
	var CurCol = $GamesHider.color.a
	if CurCol == 1:
		tween.interpolate_property($GamesHider, "color:a", 1, 0, 1, 0)
		tween.start()
		Hidden = false
	elif CurCol == 0:
		tween.interpolate_property($GamesHider, "color:a", 0, 1, 1, 0)
		tween.start()
		Hidden = true
		$GamesHider.visible = true

func _on_OptionsBtn_pressed():
	print("Options")

func _on_ExitBtn_pressed():
	get_parent().get_parent().get_parent()._exit_game()
	tween.interpolate_property($Hider, "color:a", 0, 1, 0.5, 0)
	tween.start()

# Games
func _on_FlappyGhost_pressed():
	print("testy")

func _on_GhostRun_pressed():
	pass

func _on_FairyJump_pressed():
	pass

func _on_SuperShadeBros_pressed():
	var scene = preload("res://scenes/games/SuperShadeBros2/SuperShadeBros2.tscn")
	await get_tree().idle_frame
	var Game = scene.instantiate()
	get_parent().add_child(Game)
	self.queue_free()

func _on_Pinball_pressed():
	pass

func _on_MenuTween_tween_completed(Tobject, _key):
	if Tobject == $GamesHider:
		$GamesHider.visible = Hidden


