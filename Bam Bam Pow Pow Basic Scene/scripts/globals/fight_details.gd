extends Node

class_name fight_details

var animation = ""
var newWeaponNotification = false

var op_list = []			# List of opponent detail dictionaries in order of the fights
var op_progress = 0		# Which opponent fight player has made it to
var infinity = true				# Keeps track of if in infinity mode

# Temp? Copied WeaponShop to handle selecting which campaign fight to do
var opSelectStartUp = 0
var opSelectCurrent = 0

func make_opponent(opName: String, description: String, health: int, sprite_path: String, floor_path: String,
			   background_path: String, time: int, defeated: bool, defeatable: bool,
			   weakness: String, speech: Array[String]=["No Words"]) -> Dictionary:
	var opponent: Dictionary = {
		"opName":		opName,
		"description":	description,
		"health":		health,
		"sprite_path":	sprite_path,
		"floor_path":	floor_path,
		"background_path": background_path,
		"time":			time,
		"defeated": 		defeated,
		"defeatable":	defeatable,
		"weakness":		weakness,
		"speech"	: 		speech
	}
	return opponent

# Called when the node enters the scene tree for the first time.
func _ready():
	#op_list.append(make_opponent(
		#"Sandbag",
		#"A tool for training",
		#0,
		#"res://resources/sprites/Sandbag_Sprites_PLAYTEST.png",
		#"res://Assets/tile-sakura .PNG",
		#"res://Assets/bg-sakura.PNG",
		#30,
		#false,
		#false,
		#"",
		#[
			#"...", "It cannot speak. It is a sandbag."
		#]
	#))
	
	op_list.append(make_opponent(
		"Goblin",
		"He's just a lil' guy that would die in one hit",
		1,
		"res://resources/sprites/lvl1gob-mspaint-spritesheet.png",
		"res://Assets/icon.svg",
		"res://resources/sprites/background-itemshop.png",
		30,
		false,
		true,
		"fire",
		[
			"ooooooooooooooooooooooooooooooooo",
			"i'm jst a small liddle goblin",
			"i will die to just one attack :'()"
		]
	))
	
	op_list.append(make_opponent(
		"Bat",
		"Rambunctious delinquent.",
		1000,
		"res://resources/sprites/temp-batty-spritesheet.png",
		"res://resources/sprites/mspaint-school-floor.png",
		"res://resources/sprites/mspaint-school-bg.png",
		30,
		false,
		true,
		"light",
		[
			"Hello! Loser >:D"
		]
	))
	
	op_list.append(make_opponent(
		"Sweet Baby Jones",
		"...",
		5000,
		"res://resources/sprites/bbjo-mspaint-spritesheet.png",
		"res://resources/sprites/bbjo-mspaint-floor.png",
		"res://resources/sprites/mspaint-bbjo-bg.png",
		30,
		false,
		true,
		"",
		[
			"..."
		]
	))
	
	#op_list.append(make_opponent(
		#"Dog",
		#"He's always happy to see you :D",
		#1,
		#"res://resources/sprites/Shop_sprites.png",
		#"res://Assets/icon.svg",
		#"res://Assets/backtemp.png",
		#30,
		#false,
		#true,
		#"light",
		#[
			#"Bark!",
			#"* It seems happy :) *"
		#]
	#))
	
	
	op_list.append(make_opponent(
		"Wise Man",
		"He likes to groom his beard",
		10000,
		"res://resources/sprites/master-mspaint-spritesheet.png",
		"res://Assets/tile-sakura .PNG",
		"res://Assets/bg-sakura.PNG",
		30,
		false,
		true,
		"light",
		[
			"Hmmmmmmmm"
		]
	))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
