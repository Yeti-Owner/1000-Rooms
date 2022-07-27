extends Spatial

var CameraStage = 2
var CurrentPos
var LerpWeight = 0.05
var MaxStage = 5

onready var Cam = $Camera
onready var Text = $AchievementText


func _ready():
	# Check if unlocked
	$NJ/hide.visible = !AchievementsHolder.game_data.FormagDrung
	$Beanie/hide.visible = !AchievementsHolder.game_data.Badenov
	$NotoLotta/hide.visible = !AchievementsHolder.game_data.NotoLotta
	$Asshole/hide.visible = !AchievementsHolder.game_data.Asshole
	$Wyoming/hide.visible = !AchievementsHolder.game_data.Wyoming

func _process(_delta):
	if CameraStage < 1:
		CameraStage = MaxStage
	elif CameraStage > MaxStage:
		CameraStage = 1
	
	match CameraStage:
		1:
			# New Jersey Award
			if AchievementsHolder.game_data.FormagDrung == 0:
				Text.text = "The FormagDrung achievement, find New Jersey to unlock it."
			else:
				Text.text = "The FormagDrung achievement, hope you enjoyed New Jersey."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(0,3,4-20), LerpWeight)
		2:
			# Badenov Award
			if AchievementsHolder.game_data.Badenov == 0:
				Text.text = "The Cole Badenov achievement, find the hidden Beanie to unlock."
			else:
				Text.text = "The Cole Badenov achievement, sick looking beanie tbh."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(4,3,4-20), LerpWeight)
		3:
			# NotoLotta Award
			if AchievementsHolder.game_data.NotoLotta == 0:
				Text.text = "The NotoLotta achievement, placeholder rn."
			else:
				Text.text = "The NotoLotta achievement, how tf u find this."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(8,3,4-20), LerpWeight)
		4:
			# Asshole Award
			if AchievementsHolder.game_data.Asshole == 0:
				Text.text = "Asshole achievement, get it by being an asshole to the Narrator in room 100."
			else:
				Text.text = "Asshole achievement, you are a terrible person and deserved that death."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(12,3,4-20), LerpWeight)
		5:
			# Wyoming Award
			if AchievementsHolder.game_data.Wyoming == 0:
				Text.text = "The Wyoming achievement, get it by visiting Wyoming."
			else:
				Text.text = "Wyoming doesn't exist."
			CurrentPos = Cam.global_transform.origin
			Cam.global_transform.origin = lerp(CurrentPos, Vector3(16,3,4-20), LerpWeight)
