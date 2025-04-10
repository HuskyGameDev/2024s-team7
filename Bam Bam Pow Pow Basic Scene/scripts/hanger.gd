## This script is connected to the Hanger Control Node which includes the Sprite2d
## for Hanger as well as its button. The functions under here assign the index of
## the Hanger node, the Sprite2d animation frame that represents the weapon hanger,
## and deals with button pressing of the Hanger.


extends Control
signal hangerPressed

@onready var sprite = $Sprite2dButton

# Index variable that establishes which weapon this script is representing
var i = 0
#@onready var weapon_count = WeaponInShop.weapons_list.size()

## Each instance of this script sets its index by getting the previous
## from a global variable and adding one for the next.
## Ready also includes the Sprite2d frame declaration
# Called when the node enters the scene tree for the first time.
func _ready():
	var weapon_count = WeaponInShop.weapons_list.size()
	i = WeaponInShop.weaponStartup;		# Set index for Hanger instance from global
	# Set sprite to correct condition
	if (WeaponInShop.weapons_list[i]["ownership"] == true):
		sprite.frame = (i + weapon_count * 2)
	elif (WeaponInShop.weapons_list[i]["availability"] == true):
		sprite.frame = i + weapon_count
	else:
		sprite.frame = i
	WeaponInShop.weaponStartup += 1		# Set global to next value for following instance
	# Reset the number for next ready onces reaches end of array
	if i == weapon_count-1:
		WeaponInShop.weaponStartup = 0


## HangerButton press signal. 
## Changes currentInstance to index of this hanger node.
## Emits pressed signal to WeaponShop
func _on_button_pressed():
	WeaponInShop.currentInstance = i	# Sets selected hanger instance to current
	print(i)							# Testing print to make sure right instance
	print(sprite.frame)
	hangerPressed.emit()				# Emits hangerPressed signal to WeaponShop
