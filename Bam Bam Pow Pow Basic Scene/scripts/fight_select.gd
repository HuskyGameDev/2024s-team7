## This script is connected to the WeaponShop CanvasLayer Node, under which
## all WeaponShop functions exist.
## Child scene: Hanger

extends CanvasLayer

@onready var nextButton = $VBoxContainer/Next
@onready var prevButton = $VBoxContainer/Prev
@onready var opName = $VBoxContainer/ColorRect/VBoxContainer/NameLabel
@onready var flavorText = $VBoxContainer/ColorRect/VBoxContainer/FlavorText
@onready var scroll = $Control/ScrollContainer
@onready var fight = $VBoxContainer/ColorRect/VBoxContainer/Fight
@onready var exitButton = $Sprite2dButton

## Handles changes to Selected Weapon screen
##
## Parameters:
## i		int: index of current weapon
func _changeBox(i)-> void:
	FightDetails.opSelectCurrent = i		# Set current instance of weapon global to given i
	
	# Set Next/Prev buttons to be visible (default)
	nextButton.show()
	prevButton.show()
	
	# --- Set all values in Selected Weapon Screen to correct values given index
	# Print for testing
	
	# Set name of weapon
	opName.text = FightDetails.op_list[i]["name"]
	# print(WeaponInShop.weaponsInShopArray[i])
	# Set cost of weapon
	# Set weapon flavortext
	flavorText.text = FightDetails.op_list[i]["description"]
	# print(WeaponInShop.weaponsInShopDesc[i])
	
	# --- Handle whether prev/next exist and should be shown
	
	# If index is >= maxIndex, hide next button
	if i >= 3:
		nextButton.hide()
	# If index is <= minIndex, hide prev button
	if i <= 0:
		prevButton.hide()	
	
	# Move the scroll container to center selected element
	scroll.set_h_scroll((i)*600)	#Move scroll to separation value of hbox*index
	# Note: would need to change 400 if separation value is changed
	# Couldn't figure out how to acess it from HBox :pensive: 
	
	

## Sets starting Selected Weapon Box
# Called when the node enters the scene tree for the first time.
func _ready():
	_changeBox(0)	# Starts at first weapon, changeBox to first

## Second function of HangerButton (first in Hanger script)
## Accesses pressed Hanger index and changeBoxes to it
func _on_op_select_op_pressed():
	# print("pressed!")	# Test print to see if pressable. Keep because easy to break w/ control focus
	var i = FightDetails.opSelectCurrent		# Get index of pressed hanger (index global set by Hanger)
	_changeBox(i)		#changeBox to index

##--------------------
## SELECTED WEAPON SCREEN BUTTONS
## Buttons used in the selected weapon screen
## Has buy function and scrolling by button functions

## When buy button is pressed change current weapon to owned
## This function is not connected to any real weapons systems
## nor is it connected to actual money systems


## Accesses previous weapon
func _on_prev_sprite_button_pressed():
	var inst = FightDetails.opSelectCurrent	# Grabs current weapon index
	inst -= 1			# Changes index to previous
	# Doesn't need to catch edge cases since prev is hidden at edge
	_changeBox(inst)	# changeBoxes to new index
	
## Accesses next weapon
func _on_next_sprite_button_pressed():
	var inst = FightDetails.opSelectCurrent	# Grabs current weapon index
	inst += 1			# Changes index to next
	# Doesn't need to catch edge cases since next is hidden at edge
	_changeBox(inst)	# changeBoxes to new index


func _on_fight_pressed():
	FightDetails.op_progress = FightDetails.opSelectCurrent
	SceneSwap.scene_swap("res://Scenes/Playable/CampaignFight.tscn")


func _on_sprite_2d_button_sprite_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/MainMenu.tscn")


func _on_sprite_2d_button_mouse_entered():
	exitButton.frame = 1


func _on_sprite_2d_button_mouse_exited():
	exitButton.frame = 0
