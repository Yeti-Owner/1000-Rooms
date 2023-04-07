extends CharacterBody2D

@export var speed:int = 800
@export var jumpheight:int = 1600
@export var grav:int = 4500
var velocity:Vector2 = Vector2()

func _physics_process(_delta):
	velocity.x = speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpheight
	velocity.y += grav * _delta
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity.y = velocity.y

func _lose(obstacle):
	print("You lost to: " + str(obstacle))
