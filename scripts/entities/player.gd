extends CharacterBody3D

# references
@onready var head = $Head
@onready var eyes = $Head/Eyes
@onready var anims = $Anims

# speed/movement vars
const walk_speed:float = 3.0
const sprint_speed:float = 5.2
var current_speed:float = walk_speed
var jump_velocity:float = 3.5
var gravity:float = 8.9
var lerp_speed:float = 12.0

# states
var sprinting:bool = false

# Headbob vars
const bob_freq := 3.4
const bob_amp := 0.03
var bob_time := 0.0

# misc
var direction := Vector3.ZERO
var last_velocity := Vector3.ZERO
var sens:float = EventBus.player_sensitivity
var tilt_change := 1.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens))
		head.rotate_x(deg_to_rad(-event.relative.y * sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-70), deg_to_rad(70))


## TODO, clean up into a state machine
func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	# sprint
	if Input.is_action_pressed("sprint"): # TODO add stamina checking
		sprinting = true
		current_speed = lerp(current_speed, sprint_speed, delta * lerp_speed)
	else:
		sprinting = false
		current_speed = lerp(current_speed, walk_speed, delta * lerp_speed)
	
	# gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# jump
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		anims.play("jump", 0.2)
	
	# handle landing
	if is_on_floor():
		if last_velocity.y < 0.0:
			anims.play("land", 0.2)
	
	# movement
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized()), delta * lerp_speed)
	
	if is_on_floor():
		if direction: # if moving
			velocity.x = direction.x * current_speed
			velocity.z = direction.z * current_speed
		else:
			velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 6.5)
			velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 6.5)
	else: # airborne inertia
		velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 3.0)
	
	# headbob
	bob_time += delta * velocity.length() * float(is_on_floor())
	_headbob(bob_time)
	
	# camera tilt
	_cam_tilt(input_dir)
	
	last_velocity = velocity
	move_and_slide()

func _headbob(time):
	var pos := Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	pos.x = cos(time * bob_freq/2) * bob_amp
	eyes.transform.origin = pos

func _cam_tilt(input_dir):
	var newx_tilt:float = 0 - (sign(input_dir.x) * tilt_change)
	eyes.rotation_degrees.z = lerp(eyes.rotation_degrees.z, newx_tilt, 0.08)
	var newy_tilt:float = 0 + (sign(input_dir.y) * tilt_change)
	eyes.rotation_degrees.x = lerp(eyes.rotation_degrees.x, newy_tilt, 0.08)
