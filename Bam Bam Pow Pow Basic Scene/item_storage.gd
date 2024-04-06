extends Node

var money;
var itemsList = [];
signal reload

# Called when the node enters the scene tree for the first time.
func _ready():
	money = 10000;
	for i in range(100):
		itemsList.append([])
		itemsList[i].append(null)
		itemsList[i].append(0)
		itemsList[i].append(null)
		itemsList[i].append(false)
		itemsList[i].append(0)
		
	itemsList[1][0] = "Piggy Bank"
	itemsList[1][1] = 100
	itemsList[1][2] = "res://Assets/icon.svg"
	itemsList[1][3] = false
	itemsList[1][4] = 1.2
	itemsList[11][0] = "Sharper Axes"
	itemsList[11][1] = 200
	itemsList[11][2] = "res://Assets/smile2.png"
	itemsList[11][3] = false
	itemsList[11][4] = 1.2
	itemsList[12][0] = "Sharper Fists"
	itemsList[12][1] = 500
	itemsList[12][2] = "res://Assets/smile2.png"
	itemsList[12][3] = false
	itemsList[12][4] = 1.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(str(money))
	for i in range(100):
		if (itemsList[i][3] == true):
			save_file.store_line(str(1))
		else:
			save_file.store_line(str(0))

func load_game():
	print("Load")
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var content = save_file.get_as_text()
	money = int(content.get_slice("\n", 0))
	var item = 0
	for i in range(100):
		if (content.get_slice("\n", item+1) == "1"):
			itemsList[item][3] = true
		else:
			itemsList[item][3] = false
		item = item+1

func printItems():
	for i in range(100):
		if (itemsList[i][3] == true):
			print(i)
