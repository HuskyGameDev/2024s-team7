extends Node

var money;
var itemsList = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	money = 10000;
	for i in range(1000):
		itemsList.append([])
		itemsList[i].append(0)
		itemsList[i].append(null)
		itemsList[i].append(0)
		itemsList[i].append(null)
		itemsList[i].append(false)
		
	itemsList[123][0] = 123
	itemsList[123][1] = "Name"
	itemsList[123][2] = 100
	itemsList[123][3] = "res://Assets/icon.svg"
	itemsList[123][4] = false
	itemsList[345][0] = 345
	itemsList[345][1] = "Name"
	itemsList[345][2] = 200
	itemsList[345][3] = "res://Assets/smile2.png"
	itemsList[345][4] = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func printItems():
	for i in range(1000):
		if (itemsList[i][0] != 0) && (itemsList[i][4] == true):
			print(i)
