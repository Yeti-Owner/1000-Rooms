extends Node

# References
@onready var Transitions := $TransitionManager
@onready var Canvas := $CanvasLayer
@onready var GameScene := $GameScene/GameViewport
@onready var GameViewportContainer := $GameScene
@onready var GameHud := $GameScene/HUD
@onready var environment:Environment = $GameScene/GameViewport.world.environment
@onready var TextureHolder := $CanvasLayer/Transitions/TextureRect

var SceneToLoad: String
var CurrentScene
var HudMode:String = "none" : set = _init_HUD
var NextTransition
var CurrentMode:String

signal FakeFadeDone

func _ready():
	RenderingServer.scenario_set_reflection_atlas_size(GameScene.find_world().scenario, 2048, 8)
# warning-ignore:return_value_discarded
	Settingsholder.connect("bloom_changed",Callable(self,"_bloom"))
# warning-ignore:return_value_discarded
	Settingsholder.connect("brightness_changed",Callable(self,"_brightness"))
# warning-ignore:return_value_discarded
	Settingsholder.connect("quality_bloom_changed",Callable(self,"_quality_bloom"))
	
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
		await get_tree().idle_frame
	
	var _scene = load(SceneToLoad)
	var _s = _scene.instantiate()
	GameScene.add_child(_s, true)
	CurrentScene = _s
	_fade_in()

func _reload_scene():
	Transitions.play("fade_out")

func _fade_in():
	RenderingServer.scenario_set_reflection_atlas_size(GameScene.find_world().scenario, 2048, 8)
	if NextTransition != null:
		Transitions.play(NextTransition)

func _init_HUD(mode):
	CurrentMode = mode
	match mode:
		"none":
			_swap_HUD(0)
		"ingame":
			_swap_HUD(0, "res://scenes/UI/GUI.tscn")
		"mainmenu":
			_swap_HUD(0, "res://scenes/StartMenuV2.tscn")
		"achievement":
			_swap_HUD(0, "res://scenes/AchievementHolder.tscn")
		"deathscreen":
			_swap_HUD(1, "res://scenes/DeathScreen.tscn")
		"endscreen":
			_swap_HUD(1, "res://scenes/EndScreen.tscn")

func _swap_HUD(step, scene = null):
	match step:
		0:
			for child in GameHud.get_children():
				child.queue_free()
			if scene != null:
				var _s = load(scene).instantiate()
				GameHud.add_child(_s)
		1:
			for child in GameHud.get_children():
				child.queue_free()
			for scene in GameScene.get_children():
				scene.queue_free()
			var _s = load(scene).instantiate()
			GameHud.add_child(_s)

# WorldEnvironment Shenanigans
func _bloom():
	environment.set_glow_bloom(0.75)
	if (Settingsholder.save_data.BloomSet):
#		environment.set_glow_bloom(0.75)
		environment.set_adjustment_saturation(1.7)
	else:
		Settingsholder.save_data.QualityBloom = 0
#		environment.set_glow_bloom(0)
		environment.set_adjustment_saturation(1.5)
		environment.glow_bicubic_upscale = false
		environment.glow_high_quality = false

func _brightness():
	environment.set_adjustment_brightness(float(Settingsholder.save_data.Brightness)/8)

func _quality_bloom():
	if (Settingsholder.save_data.QualityBloom):
		Settingsholder.save_data.BloomSet = 1
		environment.set_glow_bloom(0.75)
		environment.set_adjustment_saturation(1.7)
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
