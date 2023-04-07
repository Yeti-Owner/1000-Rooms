extends RayCast3D

var current_collider

@onready var interaction_label = get_node("/root/SceneManager/GameScene/HUD/GUI/InteractLabel")
@onready var interaction_hand = get_node("/root/SceneManager/GameScene/HUD/GUI/hand/handpng")

func _ready():
	interaction_hand.visible = false
	set_interaction_text("")

func _process(_delta):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		interaction_hand.visible = true
		if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider
		
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		interaction_hand.visible = false
		current_collider = null	
		set_interaction_text("")

func set_interaction_text(text):
	if !text:
		interaction_label.set_text("")
		interaction_label.set_visible(false)
	else:
		interaction_label.set_text(text)
		interaction_label.set_visible(true)
