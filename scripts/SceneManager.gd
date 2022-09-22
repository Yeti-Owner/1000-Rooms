extends Node

# References
onready var Transitions = $TransitionManager
onready var Canvas = $CanvasLayer

onready var GameScene = $GameScene/GameViewport
onready var GameViewportContainer = $GameScene
onready var GameHud = $GameScene/HUD

var SceneToLoad: String
var CurrentScene

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

func _fade_in():
	Transitions.play("fade_in")
