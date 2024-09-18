extends Node

var item_list = []
@onready var itemMax = 0;

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_list.append(make_item(
		"Uppercut Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		1,
		1.5,
		4
	))
	itemMax += 1;
	
	item_list.append(make_item(
		"Low Blow Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		2,
		1.6,
		4
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Brass Knuckles",
		700,
		false,
		MULTTYPE.SPECIFIC,
		0,
		1.2,
		12
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Bird Punching Glasses",
		700,
		false,
		MULTTYPE.DIRECTION,
		1,
		1.4,
		11
	))
	
	itemMax += 1;

	item_list.append(make_item(
		"Danger Short",
		700,
		false,
		MULTTYPE.DIRECTION,
		2,
		1.6,
		9
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Gun",
		5000,
		false,
		MULTTYPE.SPECIFIC,
		15,
		50,
		2
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"High Kick Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		6,
		1.5,
		5
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Heel Slam Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		7,
		1.6,
		5
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Leg Sweep Scroll",
		500,
		false,
		MULTTYPE.SPECIFIC,
		8,
		1.1,
		5
	))
	
	itemMax += 1;

	item_list.append(make_item(
		"Axe Slam",
		1000,
		false,
		MULTTYPE.SPECIFIC,
		12,
		3,
		7
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		MULTTYPE.MONEY,
		-1,
		1.2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		MULTTYPE.MONEY,
		-1,
		2,
		16
	))
	
	itemMax += 1;
	
	for item in item_list:
		match item["type"]:
			MULTTYPE.MONEY:
				moneyItems.append(item)
			MULTTYPE.BASE:
				baseItems.append(item)
			MULTTYPE.DIRECTION:
				directionItems.append(item)
			MULTTYPE.SPECIFIC:
				specificItems.append(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
