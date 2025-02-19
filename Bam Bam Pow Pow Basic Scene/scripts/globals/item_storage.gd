extends Node

var money # Money player has
var itemsList = [] # Array to store all items


var moneyItems = []			# Only affect money
var baseItems = []			# Only affect base multipliers
var directionItems = []		# Only affect directional attacks
var specificItems = []		# Allow and multiply a specific attack that is not a base attack
var itemMax = 0
var fightvisit = 0
var inputtoggle = true
var EquipScreen = preload("res://Scenes/Playable/EquipScreen.tscn").instantiate()
var WeaponShop = preload("res://Scenes/Playable/WeaponShop.tscn").instantiate()

@onready var maxequips = 5
var equipped_items = [] # Array of equipped item id's initialized to -1 (not real id)
@onready var equipped_weapon = "spear"

## To be removed!!!! :|
enum MULTTYPE {
	MONEY,
	BASE,
	DIRECTION,
	SPECIFIC
}

## Owned items list
#var owned_items: Array[Dictionary] = []

signal reload

# Called when the node enters the scene tree for the first time.
func _ready():
	money = 0;
	itemsList = ItemCreation.item_list
	itemMax = ItemCreation.itemMax
	fightvisit = 0
	for i in range(maxequips*3):
		equipped_items.append(-1)

# Gives money based on score obtained in fight scene
func calc_money(score):
	money += score*self.moneyMult

# Adds to fightvisit to be used in hiding the screen of input hints
func fightvisitup():
	fightvisit = fightvisit + 1

# Save game function, stores money player has and whether items are owned
func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(str(money))
	for i in range(itemsList.size()):
		if (itemsList[i]["owned"] == true):
			if (itemsList[i]["equipped"] == true):
				save_file.store_line(str(2))
			else:
				save_file.store_line(str(1))
		else:
			save_file.store_line(str(0))
	for i in range(WeaponInShop.weaponOwnership.size()):
		if WeaponInShop.weaponOwnership[i] == true:
			save_file.store_line(str(1))
		else:
			save_file.store_line(str(0))
	save_file.store_line(equipped_weapon)

# Load game function, updates owned status on items and money depending on what is 
# in save file
func load_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var content = save_file.get_as_text()
	money = int(content.get_slice("\n", 0))
	maxequips = 5
	var item_id = 0
	for j in ItemStorage.maxequips:
		ItemStorage.equipped_items[j] = -1
	for i in range(itemsList.size()):
		if (content.get_slice("\n", item_id+1) == "1"):
			itemsList[item_id]["owned"] = true
			itemsList[item_id]["equipped"] = false
			persistentItemLoad(item_id)
			#owned_items.append(itemsList[item_id])
		elif (content.get_slice("\n", item_id+1) == "2"):
			var equipped = 0
			itemsList[item_id]["owned"] = true
			itemsList[item_id]["equipped"] = true
			for j in ItemStorage.maxequips:
				if (ItemStorage.equipped_items[j] != -1):
					equipped = equipped + 1
			if (equipped != ItemStorage.maxequips):
				ItemStorage.equipped_items[equipped] = item_id
			if get_tree().current_scene.name == "EquipScreen":
				EquipScreen.reload_equipped()
		else:
			itemsList[item_id]["owned"] = false
		item_id = item_id+1
	for i in range(WeaponInShop.weaponOwnership.size()):
		if (content.get_slice("\n", item_id+1) == "1"):
			WeaponInShop.weaponOwnership[i] = true
		else:
			WeaponInShop.weaponOwnership[i] = false
		item_id = item_id+1
	print(WeaponInShop.weaponOwnership)
	if (get_tree().current_scene.name == "WeaponShop"):
		var i = WeaponInShop.currentInstance
		WeaponShop._changeBox(i)
	if (get_tree().current_scene.name == "EquipScreen"):
		EquipScreen.equip_unequip_button.visible = false
	equipped_weapon = content.get_slice("\n", item_id+1)
	print(equipped_weapon)

# Prints all owned items, currently unused
func printItems():
	for item in itemsList:
		if (item["owned"] == true):
			print(item)

func persistentItemLoad(id):
	var effects = ItemStorage.itemsList[id]["on_buy"]
	for key in effects:
		if key == "moreequips":
			print("Max Equips Change")
			ItemStorage.maxequips += effects[key]

# Deletes save file by overwriting with no money and no items
func restart_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(str(0))
	for i in range(itemsList.size()):
		save_file.store_line(str(0))
