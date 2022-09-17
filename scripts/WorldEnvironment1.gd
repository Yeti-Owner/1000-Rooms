extends WorldEnvironment

var UsableBrightness = float(Settingsholder.save_data.Brightness)/10

func _ready():
# warning-ignore:return_value_discarded
	Settingsholder.connect("bloom_changed", self, "_bloom")
# warning-ignore:return_value_discarded
	Settingsholder.connect("brightness_changed", self, "_brightness")
# warning-ignore:return_value_discarded
	Settingsholder.connect("quality_bloom_changed", self, "_quality_bloom")
	
	_bloom()

func _bloom():
	if (Settingsholder.save_data.BloomSet):
		environment.set_glow_bloom(0.75)
	else:
		Settingsholder.save_data.QualityBloom = 0
		environment.set_glow_bloom(0)
		environment.glow_bicubic_upscale = false
		environment.glow_high_quality = false

func _brightness():
	UsableBrightness = float(Settingsholder.save_data.Brightness)/10
	environment.set_adjustment_brightness(UsableBrightness)

func _quality_bloom():
	if (Settingsholder.save_data.QualityBloom):
		Settingsholder.save_data.BloomSet = 1
		environment.set_glow_bloom(0.75)
		environment.glow_bicubic_upscale = true
		environment.glow_high_quality = true
	else:
		environment.glow_bicubic_upscale = false
		environment.glow_high_quality = false
