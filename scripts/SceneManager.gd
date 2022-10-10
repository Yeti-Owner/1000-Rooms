extends Node

# References
onready var Transitions = $TransitionManager
onready var Canvas = $CanvasLayer
onready var GameScene = $GameScene/GameViewport
onready var GameViewportContainer = $GameScene
onready var GameHud = $GameScene/HUD
onready var environment = $GameScene/GameViewport.world.environment

var SceneToLoad: String
var CurrentScene
var HudMode:String = "none" setget _init_HUD
var UsableBrightness = float(Settingsholder.save_data.Brightness)/8

func _ready():
# warning-ignore:return_value_discarded
	Settingsholder.connect("bloom_changed", self, "_bloom")
# warning-ignore:return_value_discarded
	Settingsholder.connect("brightness_changed", self, "_brightness")
# warning-ignore:return_value_discarded
	Settingsholder.connect("quality_bloom_changed", self, "_quality_bloom")
	
	_bloom()
	
	GameViewportContainer.mouse_filter = 0

func _change_scene(scene):
	Transitions.play("fade_out")
	SceneToLoad = scene

func _scene_load():
	if CurrentScene != null:
		CurrentScene.queue_free()
		yield(get_tree(), "idle_frame")
	
	var _scene = load(SceneToLoad)
	var s = _scene.instance()
	
	GameScene.add_child(s, true)
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


# WorldEnvironment Shenanigans
func _bloom():
	if (Settingsholder.save_data.BloomSet):
		environment.set_glow_bloom(0.75)
	else:
		Settingsholder.save_data.QualityBloom = 0
		environment.set_glow_bloom(0)
		environment.glow_bicubic_upscale = false
		environment.glow_high_quality = false

func _brightness():
	UsableBrightness = float(Settingsholder.save_data.Brightness)/8
	environment.set_adjustment_brightness(UsableBrightness)

func _quality_bloom():
	if (Settingsholder.save_data.QualityBloom):
		Settingsholder.save_data.BloomSet = 1
		environment.set_glow_bloom(0.75)
		environment.glow_bicubic_upscale = true
		environment.glow_high_quality = true
	else:
		environment.glow_bicubic_upscale = false
		environment.glow_high_quality = false
