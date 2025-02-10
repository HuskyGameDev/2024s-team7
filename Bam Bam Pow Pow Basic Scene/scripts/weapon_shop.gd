## This script is connected to the WeaponShop CanvasLayer Node, under which
## all WeaponShop functions exist.
## Child scene: Hanger

# Note: At the moment (10/6/24) WeaponShop is not connected to any weapon functions

extends CanvasLayer

@onready var nextButton = $VBoxContainer/Next
@onready var prevButton = $VBoxContainer/Prev
@onready var weaponName = $VBoxContainer/ColorRect/VBoxContainer/NameLabel
@onready var priceLabel = $VBoxContainer/ColorRect/VBoxContainer/ToBuy/PriceLabel
@onready var flavorText = $VBoxContainer/ColorRect/VBoxContainer/FlavorText
@onready var scroll = $Control/ScrollContainer
@onready var toBuy = $VBoxContainer/ColorRect/VBoxContainer/ToBuy
@onready var bought = $VBoxContainer/ColorRect/VBoxContainer/Bought
@onready var hazard = $HazardButton
@onready var warning = $WarningScreen
var speed_flash = 1

## Handles changes to Selected Weapon screen
##
## Parameters:
## i		int: index of current weapon
func _changeBox(i)-> void:
	WeaponInShop.currentInstance=i		# Set current instance of weapon global to given i
	
	# Set Next/Prev buttons to be visible (default)
	nextButton.show()
	prevButton.show()
	
	# --- Set all values in Selected Weapon Screen to correct values given index
	# Print for testing
	
	# Set name of weapon
	weaponName.text = WeaponInShop.weapons_list[i]["name"]
	# print(WeaponInShop.weaponsInShopArray[i])
	# Set cost of weapon
	priceLabel.text = str(WeaponInShop.weapons_list[i]["cost"])
	# print(str(WeaponInShop.weaponsInShopCostsArray[i]))
	# Set weapon flavortext
	flavorText.text = WeaponInShop.weapons_list[i]["description"]
	# print(WeaponInShop.weaponsInShopDesc[i])
	
	# --- Handle whether prev/next exist and should be shown
	
	# If index is >= maxIndex, hide next button
	if i >= WeaponInShop.weapons_list.size()-1:
		nextButton.hide()
	# If index is <= minIndex, hide prev button
	if i <= 0:
		prevButton.hide()	
	
	# Move the scroll container to center selected element
	scroll.set_h_scroll((i)*400)	#Move scroll to separation value of hbox*index
	# Note: would need to change 400 if separation value is changed
	# Couldn't figure out how to acess it from HBox :pensive: 
	
	
	# Gross way to find out if weapon i is owned and change Selected Weapon Screen options: 
	# If it is/isn't owned, change Selected Weapon Screen respectively
	if WeaponInShop.weapons_list[i]["ownership"]==true:
		toBuy.hide()
		bought.show()
	else:
		toBuy.show()
		bought.hide()
	# Print if weapon i is owned for testing
	print("Do you own?", WeaponInShop.weapons_list[i])
	

## Sets starting Selected Weapon Box
# Called when the node enters the scene tree for the first time.
func _ready():
	_changeBox(0)	# Starts at first weapon, changeBox to first
	# Since first weapon is Unarmed always bought, set to bought screen
	toBuy.hide()
	bought.show()
	
	if WeaponInShop.weaponsOpened == false:
		Dialogic.start('weaponShop')
	WeaponInShop.weaponsOpened = true

## Not necessary yet. Kept only for potential later convenience.
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hazard.modulate.a > 0.99:
		speed_flash *= -1
	elif hazard.modulate.a < 0.5:
		speed_flash *= -1
	hazard.modulate = Color(1, 1, 1, hazard.modulate.a + speed_flash * delta)


## Second function of HangerButton (first in Hanger script)
## Accesses pressed Hanger index and changeBoxes to it
func _on_hanger_hanger_pressed():
	print("pressed!")	# Test print to see if pressable. Keep because easy to break w/ control focus
	var i = WeaponInShop.currentInstance		# Get index of pressed hanger (index global set by Hanger)
	_changeBox(i)		#changeBox to index

##--------------------
## SELECTED WEAPON SCREEN BUTTONS
## Buttons used in the selected weapon screen
## Has buy function and scrolling by button functions

## When buy button is pressed change current weapon to owned
## This function is not connected to any real weapons systems
## nor is it connected to actual money systems
func _on_buy_button_pressed():
	var i = WeaponInShop.currentInstance	# Get current weapon idex
	WeaponInShop.weaponOwnership[i]=true	# Check if current weapon is owned
	_changeBox(i)	#Changebox to new bought/buy settings

## Accesses previous weapon
func _on_prev_sprite_button_pressed():
	var inst = WeaponInShop.currentInstance	# Grabs current weapon index
	inst -= 1			# Changes index to previous
	# Doesn't need to catch edge cases since prev is hidden at edge
	_changeBox(inst)	# changeBoxes to new index
	
## Accesses next weapon
func _on_next_sprite_button_pressed():
	var inst = WeaponInShop.currentInstance	# Grabs current weapon index
	inst += 1			# Changes index to next
	# Doesn't need to catch edge cases since next is hidden at edge
	_changeBox(inst)	# changeBoxes to new index

##--------------------
## MENU BUTTON ROW
## Set of buttons that exist in both shops and inventory
## Access other scenes and save options




## Swaps scene to main menu
func _on_main_menu_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/MainMenu.tscn");	# Swaps

## Swaps scene to settings
func _on_settings_button_pressed():
	Global.prev_scene = get_tree().current_scene.scene_file_path #I don't know why this is here I copied allen
	SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn");	# Swaps

## Swaps scene to ItemShop
func _on_item_shop_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/ItemShop.tscn");	# Swaps

## Swaps scene to Fight
func _on_fight_scene_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn");	# Swaps

## Unimplemented
## Eventually will save game
func _on_save_game_button_pressed():
	# TEMP UTILITY: MOVES TO SELECTION SCREEN
	SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")

## Unimplemented
## Eventually will load game
func _on_load_game_button_pressed():
	pass


##--------------------
## HAZARD SCREEN 10/6/24
## Hazard screen is a temporary popup that explains to the user
## the current problems with WeaponShop for playtest

## When hazard button is clicked: warning popup screen is shown
func _on_hazard_button_sprite_button_pressed():
	warning.visible = !warning.visible	# Warning popup


## When close button is clicked: warning popup screen is closed
func _on_close_pressed():
	warning.hide()	# Close Warning popup
