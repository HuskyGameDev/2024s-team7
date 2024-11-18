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

@onready var maxequips = 6
var equipped_items = [] # Array of equipped item id's initialized to -1 (not real id)


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
			save_file.store_line(str(1))
		else:
			save_file.store_line(str(0))

# Load game function, updates owned status on items and money depending on what is 
# in save file
func load_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var content = save_file.get_as_text()
	money = int(content.get_slice("\n", 0))
	var item_id = 0
	for i in range(itemsList.size()):
		if (content.get_slice("\n", item_id+1) == "1"):
			itemsList[item_id]["owned"] = true
			#owned_items.append(itemsList[item_id])
		else:
			itemsList[item_id]["owned"] = false
		item_id = item_id+1

# Prints all owned items, currently unused
func printItems():
	for item in itemsList:
		if (item["owned"] == true):
			print(item)

# Deletes save file by overwriting with no money and no items
func restart_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(str(0))
	for i in range(itemsList.size()):
		save_file.store_line(str(0))
