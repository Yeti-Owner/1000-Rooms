extends WorldEnvironment

var UsableBrightness = float(Settingsholder.Brightness)/10

func _ready():
# warning-ignore:return_value_discarded
	Settingsholder.connect("bloom_changed", self, "_bloom")
# warning-ignore:return_value_discarded
	Settingsholder.connect("brightness_changed", self, "_brightness")


func _bloom():
	if (Settingsholder.BloomSet):
		environment.set_glow_bloom(0.75)
	else:
		environment.set_glow_bloom(0)

func _brightness():
	UsableBrightness = float(Settingsholder.Brightness)/10
	environment.set_adjustment_brightness(UsableBrightness)
