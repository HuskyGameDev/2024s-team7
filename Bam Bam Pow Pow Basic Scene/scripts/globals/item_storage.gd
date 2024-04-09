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
	money = 10000;
	
	itemsList.append(make_item(
		"Piggy Bank",
		100,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		"res://Assets/icon.svg"
	))
	
	itemsList.append(make_item(
		"Sharper Axes",
		200,
		false,
		MULTTYPE.SPECIFIC,
		10,
		1.2,
		"res://Assets/smile2.png"
	))
	
	itemsList.append(make_item(
		"Uppercut Glove",
		1000,
		false,
		MULTTYPE.SPECIFIC,
		1,
		1.5,
		"res://Assets/icon.svg"
	))
	
	itemsList.append(make_item(
		"Sharper Up",
		500,
		false,
		MULTTYPE.DIRECTION,
		1,
		2,
		"res://Assets/smile2.png"
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

func make_item(name, price, owned, type, index, mult, sprite) -> Dictionary:
	var item: Dictionary = {
		"name" 		: name,
		"price" 	: price,
		"owned" 	: owned,
		"type" 		: type,
		"index" 	: index,
		"mult" 		: mult,
		"sprite" 	: sprite
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
	print("Load")
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
	save_file.store_line(str(10000))
	for i in range(itemsList.size()):
		save_file.store_line(str(0))
