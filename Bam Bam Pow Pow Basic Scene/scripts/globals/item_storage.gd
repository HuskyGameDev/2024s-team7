extends Node

var money
var itemsList = []

var moneyItems = []			# Only affect money
var baseItems = []			# Only affect base multipliers
var directionItems = []		# Only affect directional attacks
var specificItems = []		# Allow and multiply a specific attack that is not a base attack

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
	
	itemsList.append(make_item(
		"Uppercut Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		1,
		1.5,
		4
	))
	
	itemsList.append(make_item(
		"Low Blow Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		2,
		1.6,
		4
	))
	
	itemsList.append(make_item(
		"Brass Knuckles",
		700,
		false,
		MULTTYPE.SPECIFIC,
		0,
		1.2,
		12
	))
	
	itemsList.append(make_item(
		"Bird Punching Glasses",
		700,
		false,
		MULTTYPE.DIRECTION,
		1,
		1.4,
		11
	))

	itemsList.append(make_item(
		"Danger Short",
		700,
		false,
		MULTTYPE.DIRECTION,
		2,
		1.6,
		9
	))
	
	itemsList.append(make_item(
		"Gun",
		5000,
		false,
		MULTTYPE.SPECIFIC,
		15,
		50,
		2
	))
	
	itemsList.append(make_item(
		"High Kick Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		6,
		1.5,
		5
	))
	
	itemsList.append(make_item(
		"Heel Slam Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		7,
		1.6,
		5
	))
	
	itemsList.append(make_item(
		"Leg Sweep Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		8,
		1.1,
		5
	))

	itemsList.append(make_item(
		"Axe Slam",
		1000,
		false,
		MULTTYPE.SPECIFIC,
		12,
		3,
		7
	))
	
	itemsList.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemsList.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	for item in itemsList:
		match item["type"]:
			MULTTYPE.MONEY:
				moneyItems.append(item)
			MULTTYPE.BASE:
				baseItems.append(item)
			MULTTYPE.DIRECTION:
				directionItems.append(item)
			MULTTYPE.SPECIFIC:
				specificItems.append(item)

func calc_money(score):
	money += score*self.moneyMult
	

func make_item(name, price, owned, type, index, mult, sprite_index) -> Dictionary:
	var item: Dictionary = {
		"name" 		: name,
		"price" 	: price,
		"owned" 	: owned,
		"type" 		: type,
		"index" 	: index,
		"mult" 		: mult,
		"sprite" 	: sprite_index
	}
	return item


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
