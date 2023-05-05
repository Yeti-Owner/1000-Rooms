extends Spatial

var CameraStage:int = 5
var CurrentPos:Vector3
var LerpWeight:float = 0.05
var MaxStage:int = 10

onready var parent := get_parent()
onready var Cam := self
onready var Text := get_parent().get_node("Renderer/AchievementText")

func _ready():
	# Connect Signals
# warning-ignore:return_value_discarded
	get_node("/root/SceneManager/GameScene/HUD/AchievementHolder").connect("LeftA", self, "_left")
# warning-ignore:return_value_discarded
	get_node("/root/SceneManager/GameScene/HUD/AchievementHolder").connect("RightA", self, "_right")
	
	# Check if unlocked
	
	var achievements := ["FormagDrung", "Badenov", "NotoLotta", "Asshole", "Wyoming", "Shai", "Ufrz", "Hell", "IQTest"]
	for achievement in achievements:
		var node_name = "Renderer/" + achievement + "/hide"
		parent.get_node(node_name).visible = !AchievementsHolder.game_data[achievement]

func _process(_delta):
	if CameraStage < 1:
		CameraStage = MaxStage
	elif CameraStage > MaxStage:
		CameraStage = 1
	
	match CameraStage:
		1:
			# New Jersey Award
			if AchievementsHolder.game_data.FormagDrung == 0:
				Text.text = "Visit New Jersey in room 50."
			else:
				Text.text = "The FormagDrung achievement, hope you enjoyed New Jersey."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(0,3,4), LerpWeight)
		2:
			# Badenov Award
			if AchievementsHolder.game_data.Badenov == 0:
				Text.text = "Find the hidden Beanie in rooms 200-300."
			else:
				Text.text = "The Cole Badenov achievement, sick looking beanie."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(4,3,4), LerpWeight)
		3:
			# NotoLotta Award
			get_parent().get_node("Renderer/NotoLotta/hide").visible = !AchievementsHolder.game_data.NotoLotta
			if AchievementsHolder.game_data.NotoLotta == 0:
				Text.text = "Use %s to access the Dev console and fill in: blasters are BLANK." % [OS.get_scancode_string(InputMap.get_action_list("console")[0].scancode)]
			else:
				Text.text = "The NotoLotta achievement, buff lord goat."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(8,3,4), LerpWeight)
		4:
			# Asshole Award
			if AchievementsHolder.game_data.Asshole == 0:
				Text.text = "Be an asshole to the Narrator in room 100."
			else:
				Text.text = "Asshole achievement, you are a terrible person and deserved that death."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(12,3,4), LerpWeight)
		5:
			# Wyoming Award
			if AchievementsHolder.game_data.Wyoming == 0:
				Text.text = "Visit Wyoming in rooms 100-200 via a secret button."
			else:
				Text.text = "The Wyoming achievement, Wyoming doesn't exist."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(16,3,4), LerpWeight)
		6:
			# Shai Award
			if AchievementsHolder.game_data.Shai == 0:
				Text.text = "Find a secret button in rooms 200-300."
			else:
				Text.text = "The Shai achievement, Peak."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(20,3,4), LerpWeight)
		7:
			# Ufrz Award
			if AchievementsHolder.game_data.Ufrz == 0:
				Text.text = "Find XRA in rooms 100-200."
			else:
				Text.text = "The Ufrz achievement, Xavier Renegade Angel says: What Doth Life?"
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(24,3,4), LerpWeight)
		8:
			# Brawlhalla Award
			if AchievementsHolder.game_data.Brawlhalla == 0:
				Text.text = "Placeholder."
			else:
				Text.text = "Placeholder."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(28,3,4), LerpWeight)
		9:
			# Hell Award
			if AchievementsHolder.game_data.Hell == 0:
				Text.text = "Visit Hell in rooms 200-300."
			else:
				Text.text = "The Hell achievement, hope you enjoyed your stay?"
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(32,3,4), LerpWeight)
		10:
			# IQ Test Award
			if AchievementsHolder.game_data.IQTest == 0:
				Text.text = "Fail the IQ test in rooms 200-300."
			else:
				Text.text = "The IQ Test achievement, you are a failure."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(36,3,4), LerpWeight)


func _left():
	if CameraStage == 9: 
		CameraStage -= 2
	else:
		CameraStage -= 1
	
func _right():
	if CameraStage == 7:
		CameraStage += 2
	else:
		CameraStage += 1
