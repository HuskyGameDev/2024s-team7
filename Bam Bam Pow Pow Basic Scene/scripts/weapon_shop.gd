## This script is connected to the WeaponShop CanvasLayer Node, under which
## all WeaponShop functions exist.
## Child scene: Hanger

# Note: At the moment (10/6/24) WeaponShop is not connected to any weapon functions

extends CanvasLayer

# Preload all 'GetNode' s
@onready var prev_button = $Prev
@onready var next_button = $Next
@onready var buy_equip_button = $NinePatchRect/ColorRect/VBoxContainer/EquipBuyHBox/BuyEquipButton
@onready var buy_equip_label = $NinePatchRect/ColorRect/VBoxContainer/EquipBuyHBox/BuyEquipButton/BuyEquipLabel
@onready var weapon_name = $NinePatchRect/ColorRect/VBoxContainer/NameLabel
@onready var flavor_text = $NinePatchRect/ColorRect/VBoxContainer/FlavorText
@onready var scroll = $Control/ScrollContainer
@onready var price = $NinePatchRect/ColorRect/VBoxContainer/EquipBuyHBox/Price
@onready var money_label = $MoneyHBox/MoneyLabel
@onready var exitButton = $Sprite2dButton
@onready var audio_player = $AudioStreamPlayer2D

var speed_flash = 1
signal timeline_started
signal timeline_ended

func _ready():
	money_label.text = str(ItemStorage.money)
	_changeBox(0)	# Starts at first weapon, changeBox to first
	# Since first weapon is Unarmed always bought, set to bought screen
	
	if WeaponInShop.weaponsOpened == false:
		Dialogic.start('weaponShop')
	WeaponInShop.weaponsOpened = true


## Handles changes to Selected Weapon screen
##
## Parameters:
## i		int: index of current weapon
func _changeBox(i)-> void:
	WeaponInShop.currentInstance=i		# Set current instance of weapon global to given i
	
	# Set Next/Prev buttons to be visible (default)
	next_button.show()
	prev_button.show()
	
	# --- Set all values in Selected Weapon Screen to correct values given index
	# Print for testing
	
	# Set name of weapon
	weapon_name.text = WeaponInShop.weapons_list[i]["weaponName"]
	# print(WeaponInShop.weaponsInShopArray[i])
	# Set cost of weapon
	price.text = str(WeaponInShop.weapons_list[i]["cost"])
	# print(str(WeaponInShop.weaponsInShopCostsArray[i]))
	# Set weapon flavortext
	flavor_text.text = WeaponInShop.weapons_list[i]["description"]
	# print(WeaponInShop.weaponsInShopDesc[i])
	
	# --- Handle whether prev/next exist and should be shown
	
	# If index is >= maxIndex, hide next button
	if i >= WeaponInShop.weapons_list.size()-1:
		next_button.hide()
	# If index is <= minIndex, hide prev button
	if i <= 0:
		prev_button.hide()	
	
	# Move the scroll container to center selected element
	scroll.set_h_scroll((i)*400)	#Move scroll to separation value of hbox*index
	# Note: would need to change 400 if separation value is changed
	# Couldn't figure out how to acess it from HBox :pensive: 
	
	if WeaponInShop.weapons_list[i]["availability"]== true:
		if WeaponInShop.weapons_list[i]["ownership"]==true:
			price.hide()
			buy_equip_button.show()
			buy_equip_label.text = "EQUIP"
		else:
			price.show()
			buy_equip_button.show()
			buy_equip_label.text = "BUY"
	else:
		price.show()
		buy_equip_button.hide()
		price.text = "Unavailable"
	# Gross way to find out if weapon i is owned and change Selected Weapon Screen options: 
	# If it is/isn't owned, change Selected Weapon Screen respectively

	# Print if weapon i is owned for testing
	print("Do you own?", WeaponInShop.weapons_list[i])
	
## Makes all weapons appear if they are not owned and disappear if they are
func reloadWeapons():
	for i in WeaponInShop.weaponOwnership.size():
		if WeaponInShop.weaponOwnership[i]==true:
			toBuy.hide()
			bought.show()
		else:
			toBuy.show()
			bought.hide()
	

## Sets starting Selected Weapon Box
# Called when the node enters the scene tree for the first time.
func _ready():
	_changeBox(0)	# Starts at first weapon, changeBox to first
	# Since first weapon is Unarmed always bought, set to bought screen
	toBuy.hide()
	bought.show()
	
	warningLabel.hide()
	if WeaponInShop.weaponsOpened == false:
		Dialogic.connect("timeline_started", Callable(self,"_on_dialogue_started"))
		Dialogic.connect("timeline_ended", Callable(self,"_on_dialogue_ended"))
		$AnimatedSprite2D.play("talk")
		Dialogic.start('weaponShop')
	WeaponInShop.weaponsOpened = true

func _on_dialogue_started():
	pass

func _on_dialogue_ended():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = 0
	

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

func _on_buy_equip_button_button_pressed():
	match(buy_equip_label.text):
		"BUY":
			var i = WeaponInShop.currentInstance	# Get current weapon idex
			var weaponName = WeaponInShop.weapons_list[i]["weaponName"].to_lower()
			if (ItemStorage.money >= WeaponInShop.weapons_list[i]["cost"]):
				audio_player.stream = load("res://resources/sounds/Item_Purchase_Coins.wav")
				ItemStorage.money = ItemStorage.money - WeaponInShop.weapons_list[i]["cost"]
				WeaponInShop.weapons_list[i]["ownership"] = true
				_changeBox(i)	#Changebox to new bought/buy settings
				audio_player.play()
				money_label.text = str(ItemStorage.money)
			else:
				audio_player.stream = load("res://resources/sounds/Buzz.wav")
				audio_player.play()
		"EQUIP":
			var i = WeaponInShop.currentInstance
			var weaponName = WeaponInShop.weapons_list[i]["weaponName"].to_lower()
			if (weaponName == "spear"):
				ItemStorage.equipped_weapon = weaponName
				print(ItemStorage.equipped_weapon)
			elif (weaponName == "unarmed"):
				ItemStorage.equipped_weapon = weaponName
				print(ItemStorage.equipped_weapon)
			audio_player.stream = load("res://resources/sounds/WoodClick.wav")
			audio_player.play()

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

func _on_sprite_2d_button_sprite_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")

# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")
