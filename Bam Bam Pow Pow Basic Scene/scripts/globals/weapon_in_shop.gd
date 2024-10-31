## Temporary Global Variable set for 10/10 Playtest WeaponShop
## This set doesn't include any reference to actual weapons
## Kept arrays because more efficient access than dictionary during game.
## No elements added to arrays during runtime.

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

var weaponsInShopArray = ["Unarmed", "Bat", "Gun", "BBJones", "MorningStar"] # Array of all weapon names

var weaponsInShopCostsArray = [0, 20, 9999999999, 420, 2001911]		# Weapon costs
var weaponOwnership = [true,false,false,false,false]		# Weapon ownership

var weaponsInShopDesc = ["You punch things with your glass fists","Wh'ack e'm","M4 carbine Colt AR-15", "Sweet baby", "It's pretty spikey"]
# When there are more descriptions just append and put the appends in a ready function
