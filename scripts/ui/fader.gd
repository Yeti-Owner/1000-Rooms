extends CanvasLayer

signal fade_done

@onready var fade := $fade

# solid to transparent
func _fade_in(color:Color = Color(0, 0, 0), duration:float = 1.0):
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	# if different color entirely briefly change before fading
	if get_node("fade").color != color:
		tween.tween_property(get_node("fade"), "color", color, (duration/2.0))
	
	color.a = 0
	tween.tween_property(get_node("fade"), "color", color, duration)
	tween.tween_callback(_done)

# transparent to solid
func _fade_out(color:Color = Color(0, 0, 0), duration:float = 1.0):
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	# if different color entirely briefly change before fading
	if get_node("fade").color != color:
		tween.tween_property(get_node("fade"), "color", color, (duration/2.0))
	
	color.a = 1
	tween.tween_property(get_node("fade"), "color", color, duration)
	tween.tween_callback(_done)

func _done():
	emit_signal("fade_done")
