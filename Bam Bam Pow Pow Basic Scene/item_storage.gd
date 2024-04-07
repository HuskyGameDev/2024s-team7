extends Node

var money;
var itemsList = [];
enum MULTTYPE {MONEY, BASE, LITERAL, DIRECTION}
var item = {
	name = "",
	price = 0,
	sprite = "",
	owned = false,
	type = -1,
	index = -1,
	multiplier = 0
}
signal reload

# Called when the node enters the scene tree for the first time.
func _ready():
	money = 10000;
	
	for i in range(100):
		itemsList.append(item.duplicate())
	
	itemsList[20].name = "Piggy Bank"
	itemsList[20].price = 100
	itemsList[20].sprite = "res://Assets/icon.svg"
	itemsList[20].type = MULTTYPE.MONEY
	itemsList[20].multiplier = 1.2
	
	itemsList[21].name = "Sharper Axes"
	itemsList[21].price = 200
	itemsList[21].sprite = "res://Assets/smile2.png"
	itemsList[21].type = MULTTYPE.LITERAL
	itemsList[21].index = 10
	itemsList[21].multiplier = 1.2
	
	itemsList[22].name = "Sharper Up"
	itemsList[22].price = 500
	itemsList[22].sprite = "res://Assets/smile2.png"
	itemsList[22].type = MULTTYPE.DIRECTION
	itemsList[22].index = 1
	itemsList[22].multiplier = 1.5
	
	itemsList[1].name = "Uppercut Glove"
	itemsList[1].price = 1000
	itemsList[1].sprite = "res://Assets/icon.svg"
	
	itemsList[0].owned = true
	itemsList[5].owned = true
	itemsList[10].owned = true
	itemsList[15].owned = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(str(money))
	for i in range(100):
		if (itemsList[i].owned == true):
			save_file.store_line(str(1))
		else:
			save_file.store_line(str(0))

func load_game():
	print("Load")
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var content = save_file.get_as_text()
	money = int(content.get_slice("\n", 0))
	var item_id = 0
	for i in range(100):
		if (content.get_slice("\n", item_id+1) == "1"):
			itemsList[item_id].owned = true
		else:
			itemsList[item_id].owned = false
		item_id = item_id+1

func printItems():
	for i in range(100):
		if (itemsList[i].owned == true):
			print(i)

func restart_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(str(10000))
	for i in range(100):
		save_file.store_line(str(0))
