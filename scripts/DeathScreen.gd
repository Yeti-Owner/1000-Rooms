extends Control

onready var DeathText = $HBoxContainer/Label
onready var DeathReason = SaveGame.DeathReason

var text: String

var message
var messages = ["Another body left behind to be consumed by the dungeon.","Your crippled form is later found and devoured","Well that sucks.","Death comes for us all and it found you.","Your soul wanders the endless dungeon for all eternity.","Your screams echo but they fall on deaf ears.","Yet another is lost to the dungeon.","There will be no funeral for your mangled corpse."]
var stats
var tip
var bye
var byeList = ["Better luck next time!","Good Luck.","Maybe you'll make it farther next time?","Don't run out of hope yet.","There's more to explore don't forget.","I have a good feeling about your next attempt.","RIP","Good bye.","Next time will be different for sure.","Honestly surprised you lived this long."]

func _ready():
	SceneManager.HudMode = "none"
	_get_msg()

func _get_msg():
	message = messages[randi() % messages.size()]
	
	stats = str("You died to: {x}, and this is death: {y}").format({"x" : DeathReason, "y" : SaveGame.game_data.Deaths})
	
	match DeathReason:
		"ghost":
			var tips1 = ["The Ghost is not able to reach all areas so take your time when you're safe.","The Ghost is usually slow so you may be able to juke him out.","Touching him deals damage, try to avoid that."]
			tip = tips1[randi() % tips1.size()]
		"fall":
			var tips2 = ["Falling is bad, try not to.","If you really struggle with parkour maybe git gud?","When you fall you take damage, it's usually preferable to avoid that."]
			tip = tips2[randi() % tips2.size()]
		"fairy":
			var tips3 = ["The fairy will wonder around on a set path looking for you, memorize it's path to avoid it.","The fairy is usually pretty hard to juke out, it's faster than you UNLESS you sprint.","You want to keep your health above 0 usually."]
			tip = tips3[randi() % tips3.size()]
		_:
			var tips4 = ["You got killed by unknown? I'm reading the script and it just says error?","How did you manage to die? it just says null here???","You are a special kind of player being able to die to something called: unknown, like genuinely how did you die?"]
			tip = tips4[randi() % tips4.size()]
	
	bye = byeList[randi() % byeList.size()]
	_set_msg()

func _set_msg():
	text = "{message}\n\n{stats}\n\n{tip}\n\n{bye}".format({"message" : message, "stats" : stats, "tip" : tip, "bye" : bye})
	DeathText.text = text

func _on_Timer_timeout():
	SceneManager.HudMode = "ingame"
	SceneManager._change_scene(SaveGame.game_data.LastCheckPoint)
