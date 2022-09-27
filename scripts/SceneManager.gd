extends Node

# References
onready var Transitions = $TransitionManager
onready var Canvas = $CanvasLayer
onready var GameScene = $GameScene/GameViewport
onready var GameViewportContainer = $GameScene
onready var GameHud = $GameScene/HUD

var SceneToLoad: String
var CurrentScene
var HudMode:String = "none" setget _init_HUD

func _change_scene(scene):
	Transitions.play("fade_out")
	SceneToLoad = scene

func _scene_load():
	if CurrentScene != null:
		CurrentScene.queue_free()
	
	var _scene = load(SceneToLoad)
	var s = _scene.instance()
	
	GameScene.add_child(s)
	CurrentScene = s
	_fade_in()

func _reload_scene():
	Transitions.play("fade_out")

func _fade_in():
	Transitions.play("fade_in")

func _init_HUD(mode):
	print("called: " + str(mode))
	match mode:
		"none":
			for child in GameHud.get_children():
				child.queue_free()
		"ingame":
			for child in GameHud.get_children():
				child.queue_free()
			var _GUI = load("res://scenes/UI/GUI.tscn")
			var g = _GUI.instance()
			GameHud.add_child(g)
		"mainmenu":
			for child in GameHud.get_children():
				child.queue_free()
			var _mainmenu = load("res://scenes/StartMenuV2.tscn")
			var m = _mainmenu.instance()
			GameHud.add_child(m)

