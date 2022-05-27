extends WorldEnvironment

var UsableBrightness = float(Settingsholder.Brightness)/10

func _ready():
	if (Settingsholder.BloomSet):
		environment.set_glow_bloom(0.5)
	else:
		environment.set_glow_bloom(0)
	
	environment.set_adjustment_brightness(UsableBrightness)

