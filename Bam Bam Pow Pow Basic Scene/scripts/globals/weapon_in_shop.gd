## Temporary Global Variable set for 10/10 Playtest WeaponShop
## This set doesn't include any reference to actual weapons

class_name weapon_in_shop
extends Node

# Note: As of 10/6/24, none of the other functions have hard-coded values that would
# need to be changed for adding new weapons to the system.
# To do so just :
# a) add their values to the arrays below
# b) add new hanger sprite sheet
# c) change number of frames in hanger sprite sheet animation


var weapon_list = []
# weapon_list.append(1)
# WHY WON"
@onready var weaponMax = 0;

var currentInstance: int = 0 	# Which weapon we're on right now
var weaponStartup: int = 0		# Prev + to set each Hanger Node to correct weapon index 

# Array of all weapon names
var weaponsInShopArray = ["Unarmed", "Bat", "Gun", "BBJones", "MorningStar"]

# I wish I could have a goddamn 3d array without like 7 nested for loops. Fuck you Godot.
# TO DO: Turn these baddies into a Dictionary
var weaponsInShopCostsArray = [0, 20, 9999999999, 420, 2001911]		#weapon costs
var weaponOwnership = [true,false,false,false,false]	#weapon ownership (0 = not owned, 1 = owned)

var weaponsInShopDesc = ["You punch things with your glass fists","Wh'ack e'm","M4 carbine Colt AR-15", "Sweet baby", "It's pretty spikey"]
# I have very strong feelings about this Desc guy and if any of you can fix it I would
# be so very happy. I tried making this a blank array and appending it. Ya'know
# LIKE SOMEONE WHO'S NOT CRAZY
# But every time I tried to append it everything broke and I had to delete the whole thing and do it again


func make_weapon(index, name, price, owned, description) -> Dictionary:
	var weapon: Dictionary = {
		"index"	: index,
		"name" 	: name,
		"price" 	: price,
		"owned" 	: owned,
		"description" : description
	}
	return weapon
	

# wrap dictionary declarations inside a ready function
