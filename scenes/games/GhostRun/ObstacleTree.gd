extends Area2D


func _ready():
	pass 

func _on_ObstacleTree_body_entered(body):
	if body.name == "Player":
		body._lose(self.name)


func _on_Timer_timeout():
	self.queue_free()
