extends KinematicBody2D

export var speed:int = 800
export var jumpheight:int = 1600
export var grav:int = 4500
var velocity:Vector2 = Vector2()

func _physics_process(_delta):
	velocity.x = speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpheight
	velocity.y += grav * _delta
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	

func _lose(obstacle):
	print("You lost to: " + str(obstacle))
