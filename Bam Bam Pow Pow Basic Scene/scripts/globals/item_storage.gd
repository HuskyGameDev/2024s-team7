extends Node

var money
var itemsList = []

var moneyItems = []			# Only affect money
var baseItems = []			# Only affect base multipliers
var directionItems = []		# Only affect directional attacks
var specificItems = []		# Allow and multiply a specific attack that is not a base attack
var itemMax = 0;

enum MULTTYPE {
	MONEY,
	BASE,
	DIRECTION,
	SPECIFIC
}

signal reload

# Called when the node enters the scene tree for the first time.
func _ready():
	money = 0;
	itemsList = ItemCreation.item_list
	itemMax = ItemCreation.itemMax

func calc_money(score):
	money += score*self.moneyMult
	


func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(str(money))
	for i in range(itemsList.size()):
		if (itemsList[i]["owned"] == true):
			save_file.store_line(str(1))
		else:
			save_file.store_line(str(0))

func load_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var content = save_file.get_as_text()
	money = int(content.get_slice("\n", 0))
	var item_id = 0
	for i in range(itemsList.size()):
		if (content.get_slice("\n", item_id+1) == "1"):
			itemsList[item_id]["owned"] = true
		else:
			itemsList[item_id]["owned"] = false
		item_id = item_id+1

func printItems():
	for item in itemsList:
		if (item["owned"] == true):
			print(item)

func restart_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(str(0))
	for i in range(itemsList.size()):
		save_file.store_line(str(0))
