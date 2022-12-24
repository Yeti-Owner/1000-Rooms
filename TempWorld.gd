extends Spatial

export(Environment) var EnvironmentUsed
export(Environment) var EnvironmentUsed2
export(Environment) var EnvironmentUsed3


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
