extends Node3D

@export var EnvironmentUsed: Environment
@export var EnvironmentUsed2: Environment
@export var EnvironmentUsed3: Environment


func _ready():
	pass
#	SceneManager.GameScene.world.environment = EnvironmentUsed

func _on_Timer_timeout():
	$AnimationPlayer.play("NewTextures")

#func _env2():
#	SceneManager.GameScene.world.environment = EnvironmentUsed2
#
#func _env3():
#	SceneManager.GameScene.world.environment = EnvironmentUsed3
