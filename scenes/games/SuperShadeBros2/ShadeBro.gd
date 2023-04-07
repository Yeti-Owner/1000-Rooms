extends CharacterBody2D

var speed : int = 200
var jump_speed : int = -300
var grav : int = 550
var vel := Vector2()
var EnabledMovement := true

func get_input(delta):
	# Basic Movement/Input Manager
	vel.x = 0
	if Input.is_action_pressed("right"):
		vel.x += speed
	if Input.is_action_pressed("left"):
		vel.x -= speed
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y += jump_speed
	
	# Turn left or right
	if vel.x != 0:
		$Sprite2D.scale.x = -sign(vel.x)
	
	vel.y += grav * delta
	set_velocity(vel)
	set_up_direction(Vector2.UP)
	move_and_slide()
	vel = velocity

func _physics_process(delta):
	if EnabledMovement:
		get_input(delta)

func _on_ShadeArea_area_entered(area):
	if area.is_in_group("Death"):
		position = get_parent().SpawnLoc
		get_parent().Lives -= 1
	
	if area.name == "FlagArea":
		EnabledMovement = false
