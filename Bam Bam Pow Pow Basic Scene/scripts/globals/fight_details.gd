extends Node

class_name fight_details

signal shatter
var animation = ""
var newWeaponNotification = false

var high_score = 0
var win = false

var op_list = []			# List of opponent detail dictionaries in order of the fights
var op_progress = 0		# Which opponent fight player has made it to
var infinity = true		# Keeps track of if in infinity mode

## !!!! Temp additions begin !!!!
## Dependancies are the actions of new game from the menu and the end state of
## the tutorial.
## All dependancies will have "matthew_dependancy" commented with them to make
## searching for and deleting them later.

var new_game_tutorial: bool = false

## !!!! Temp additions end !!!!

# Temp? Copied WeaponShop to handle selecting which campaign fight to do
var opSelectStartUp = 0
var opSelectCurrent = 0

func make_opponent(opName: String, opName_no_space: String, description: String, health: int, sprite_path: String, background_setup_function: String, time: int, defeated: bool, first_try: bool,
			   weakness: String, record: float) -> Dictionary:
	var opponent: Dictionary = {
		"opName":		opName,
		"opName_no_space": opName_no_space,
		"description":	description,
		"health":		health,
		"sprite_path":	sprite_path,
		"background_setup_function":	background_setup_function,
		"time":			time,
		"defeated": 	defeated,
		"first_try":	first_try,
		"weakness":		weakness,
		"record":		record,
	}
	return opponent

# Called when the node enters the scene tree for the first time.
func _ready():
	
	op_list.append(make_opponent(
		"Lvl 1 Goblin",
		"Lvl1Goblin",
		"He's just a lil' guy that would die in one hit",
		1,
		"res://resources/sprites/lvl1gob-mspaint-spritesheet.png",
		"cave",
		30,
		false,
		true,
		"fire",
		50,
	))
	
	op_list.append(make_opponent(
		"Batty",
		"Batty",
		"Rambunctious delinquent.",
		300,
		"res://resources/sprites/temp-batty-spritesheet.png",
		"sakura",
		30,
		false,
		true,
		"light",
		50,
	))
	
	op_list.append(make_opponent(
		"Sweet Baby Jones",
		"SweetBabyJones",
		"...",
		500,
		"res://resources/sprites/bbjo-mspaint-spritesheet.png",
		"jonestown",
		30,
		false,
		true,
		"",
		50,
	))
	
	op_list.append(make_opponent(
		"Robit",
		"Robit",
		"A technological miracle",
		1000,
		"res://resources/sprites/bbjo-mspaint-spritesheet.png",
		"factory",
		30,
		false,
		true,
		"",
		50,
	))
	
	op_list.append(make_opponent(
		"Moon",
		"Moon",
		"Traveled a long way for this.",
		1500,
		"res://resources/sprites/temp-batty-spritesheet.png",
		"moon",
		30,
		false,
		true,
		"light",
		50,
	))
	
	op_list.append(make_opponent(
		"Sir Plomp",
		"SirPlomp",
		"Flippers with finesse.",
		3000,
		"res://resources/sprites/temp-batty-spritesheet.png",
		"fancy",
		30,
		false,
		true,
		"light",
		50,
	))
	
	op_list.append(make_opponent(
		"Baltimore",
		"Baltimore",
		"Women love me, fish fear me",
		6000,
		"res://resources/sprites/master-mspaint-spritesheet.png",
		"sakura",
		30,
		false,
		true,
		"light",
		50,
	))
	
func do_shatter():
	shatter.emit()
