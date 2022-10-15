extends Node

# References
onready var Transitions = $TransitionManager
onready var Canvas = $CanvasLayer
onready var GameScene = $GameScene/GameViewport
onready var GameViewportContainer = $GameScene
onready var GameHud = $GameScene/HUD
onready var environment = $GameScene/GameViewport.world.environment
onready var TextureHolder = $CanvasLayer/Transitions/TextureRect

var SceneToLoad: String
var CurrentScene
var HudMode:String = "none" setget _init_HUD
var UsableBrightness = float(Settingsholder.save_data.Brightness)/8
var NextTransition

signal FakeFadeDone

func _ready():
# warning-ignore:return_value_discarded
	Settingsholder.connect("bloom_changed", self, "_bloom")
# warning-ignore:return_value_discarded
	Settingsholder.connect("brightness_changed", self, "_brightness")
# warning-ignore:return_value_discarded
	Settingsholder.connect("quality_bloom_changed", self, "_quality_bloom")
	
	_bloom()
	
	GameViewportContainer.mouse_filter = 0

func _change_scene(scene:String, type := "normal"):
	match type:
		"normal":
			NextTransition = "fade_in"
			Transitions.play("fade_out")
			SceneToLoad = scene
		"achievement":
			NextTransition = null
			var img = get_viewport().get_texture().get_data()
			img.flip_y()
			var screenshot = ImageTexture.new()
			screenshot.create_from_image(img)
			TextureHolder.texture = screenshot
			SceneToLoad = scene
			Transitions.play("achievement_out")

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
	if NextTransition != null:
		Transitions.play(NextTransition)

func _init_HUD(mode):
#	print("called: " + str(mode))
	match mode:
		"none":
			for child in GameHud.get_children():
				child.queue_free()
		"ingame":
			for child in GameHud.get_children():
				child.queue_free()
			var _GUI = load("res://scenes/UI/GUI.tscn").instance()
#			var g = _GUI.instance()
#			GameHud.add_child(g)
			GameHud.add_child(_GUI)
		"mainmenu":
			for child in GameHud.get_children():
				child.queue_free()
			var _mainmenu = load("res://scenes/StartMenuV2.tscn")
			var m = _mainmenu.instance()
			GameHud.add_child(m)
		"achievement":
			for child in GameHud.get_children():
				child.queue_free()
			var _a = load("res://scenes/AchievementHolder.tscn")
			var a = _a.instance()
			GameHud.add_child(a)

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

func _fake_fade():
	Transitions.play("fake_out")

func _on_TransitionManager_animation_finished(anim_name):
	if anim_name == "fake_out":
		Transitions.play("fade_in")
		emit_signal("FakeFadeDone")
