class_name weapon_in_shop
extends Node

# Note: As of 10/6/24, none of the other functions have hard-coded values that would
# need to be changed for adding new weapons to the system.
# To do so just :
# a) add their values to the arrays below
# b) add new hanger sprite sheet
# c) change number of frames in hanger sprite sheet animation

@onready var weaponMax = 0;

var currentInstance: int = 0 	# Which weapon we're on right now
var weaponStartup: int = 0		# Prev + to set each Hanger Node to correct weapon index 

var weapons_list = []			# List of opponent detail dictionaries in order of the fights

func make_shop_weapon(weaponName: String, cost: int, availability: bool, ownership: bool, description: String):
	var shop_weapon: Dictionary = {
		"weaponName":	weaponName,
		"cost":			cost,
		"availability":	availability,
		"ownership":	ownership,
		"description":	description
	}
	return shop_weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	weapons_list.append(make_shop_weapon(
		"Unarmed",
		0,
		true,
		true,
		"Punch things with your glass fists"
	))
	weapons_list.append(make_shop_weapon(
		"Spear",
		55,
		true,
		false,
		"speary"
	))
	weapons_list.append(make_shop_weapon(
		"BBJones",
		420,
		false,
		false,
		"Sweet baby"
	))
	weapons_list.append(make_shop_weapon(
		"Bat",
		20,
		false,
		false,
		"Wh'ack e'm"
	))
	weapons_list.append(make_shop_weapon(
		"Gun",
		9999999999,
		false,
		false,
		"M4 carbine Colt AR-15"
	))



# When there are more descriptions just append and put the appends in a ready function


## UNRELATED SILLY GLOBALS FOR FIRST SCENE OPENS
var weaponsOpened = false
var itemsOpened = false
