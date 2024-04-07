extends Node

var money;
var itemsList = [];
var item = {
	name = "",
	price = 0,
	sprite = "",
	owned = false,
	multiplier = 0,
	move = ""
}
signal reload

# Called when the node enters the scene tree for the first time.
func _ready():
	money = 10000;
	
	for i in range(100):
		itemsList.append(item.duplicate())
	
	itemsList[0].name = "Piggy Bank"
	itemsList[0].price = 100
	itemsList[0].sprite = "res://Assets/icon.svg"
	itemsList[0].multiplier = 1.2
	
	itemsList[11].name = "Sharper Axes"
	itemsList[11].price = 200
	itemsList[11].sprite = "res://Assets/smile2.png"
	itemsList[11].multiplier = 1.2
	
	itemsList[12].name = "Sharper Fists"
	itemsList[12].price = 500
	itemsList[12].sprite = "res://Assets/smile2.png"
	itemsList[12].multiplier = 1.5
	
	
	
	itemsList[21].name = "Uppercut Glove"
	itemsList[21].price = 1000
	itemsList[21].sprite = "res://Assets/icon.svg"
	itemsList[21].move = "UP"


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
