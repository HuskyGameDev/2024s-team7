## This script is connected to the Hanger Control Node which includes the Sprite2d
## for Hanger as well as its button. The functions under here assign the index of
## the Hanger node, the Sprite2d animation frame that represents the weapon hanger,
## and deals with button pressing of the Hanger.


extends Control
signal hangerPressed

# Index variable that establishes which weapon this script is representing
var i = 0

## Each instance of this script sets its index by getting the previous
## from a global variable and adding one for the next.
## Ready also includes the Sprite2d frame declaration
# Called when the node enters the scene tree for the first time.
func _ready():
	i = WeaponInShop.weaponStartup;		# Set index for Hanger instance from global
	$Sprite2D.frame = i					# Set Sprite2d frame to frame at index
	
	$Sprite2dButton.frame = i					# Set Sprite2d frame to frame at index
	
	WeaponInShop.weaponStartup += 1		# Set global to next value for following instance
	# Reset the number for next ready onces reaches end of array
	if i==WeaponInShop.weapons_list.size():
		WeaponInShop.weaponStartup = 1


## HangerButton press signal. 
## Changes currentInstance to index of this hanger node.
## Emits pressed signal to WeaponShop
func _on_button_pressed():
	WeaponInShop.currentInstance = i	# Sets selected hanger instance to current
	print(i)							# Testing print to make sure right instance
	hangerPressed.emit()				# Emits hangerPressed signal to WeaponShop
