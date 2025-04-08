extends Node

class_name fight_details

var animation = ""
var newWeaponNotification = false

var high_score = 0
var win = false

var op_list = []			# List of opponent detail dictionaries in order of the fights
var op_progress = 0		# Which opponent fight player has made it to
var infinity = true		# Keeps track of if in infinity mode

# Temp? Copied WeaponShop to handle selecting which campaign fight to do
var opSelectStartUp = 0
var opSelectCurrent = 0

func make_opponent(opName: String, description: String, health: int, sprite_path: String, background_setup_function: String, time: int, defeated: bool, defeatable: bool,
			   weakness: String, record: float, speech: Array[String]=["No Words"]) -> Dictionary:
	var opponent: Dictionary = {
		"opName":		opName,
		"description":	description,
		"health":		health,
		"sprite_path":	sprite_path,
		"background_setup_function":	background_setup_function,
		"time":			time,
		"defeated": 		defeated,
		"defeatable":	defeatable,
		"weakness":		weakness,
		"record":		record,
		"speech": 		speech,
	}
	return opponent

# Called when the node enters the scene tree for the first time.
func _ready():
	
	op_list.append(make_opponent(
		"Goblin",
		"He's just a lil' guy that would die in one hit",
		1,
		"res://resources/sprites/lvl1gob-mspaint-spritesheet.png",
		"cave",
		30,
		false,
		true,
		"fire",
		50,
		[
			"ooooooooooooooooooooooooooooooooo",
			"i'm jst a small liddle goblin",
			"i will die to just one attack :'()"
		]
	))
	
	op_list.append(make_opponent(
		"Bat",
		"Rambunctious delinquent.",
		300,
		"res://resources/sprites/temp-batty-spritesheet.png",
		"school",
		30,
		false,
		true,
		"light",
		50,
		[
			"Hello! Loser >:D"
		]
	))
	
	op_list.append(make_opponent(
		"Sweet Baby Jones",
		"...",
		3000,
		"res://resources/sprites/bbjo-mspaint-spritesheet.png",
		"jonestown",
		30,
		false,
		true,
		"",
		50,
		[
			"..."
		]
	))
	
	op_list.append(make_opponent(
		"Wise Man",
		"He likes to groom his beard",
		8000,
		"res://resources/sprites/master-mspaint-spritesheet.png",
		"sakura",
		30,
		false,
		true,
		"light",
		50,
		[
			"Hmmmmmmmm"
		]
	))
