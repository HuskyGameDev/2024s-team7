extends Node

var item_list = [] # The list of items
@onready var itemMax = 0; # The number of items currently made and implemented

enum MULTTYPE {
	MONEY,
	BASE,
	DIRECTION,
	SPECIFIC
}

# Make item function that assigns parts of item to whatever they are set as when called
func make_item(item_name: String, price: int, owned: bool, 
			   effects: Dictionary, sprite_index: int, equipped: bool, 
			   descript: Array[String]=["No Description"], on_buy: Dictionary = {"no_effect": 0}) -> Dictionary:
	var item: Dictionary = {
		"item_name" : item_name,
		"price" 	: price,
		"owned" 	: owned,
		"effects" 	: effects,
		"on_buy"	: on_buy,
		"sprite" 	: sprite_index,
		"equipped"	: equipped,
		"descript"	: descript
	}
	itemMax += 1
	return item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_list.append(make_item(
		"Uppercut Scroll",
		1400,
		true,
		{
			"light_up": 0.5
		},
		1,
		false,
		[
			"Adds a 0.5 multiplier to your light up attacks."	
		]
	))
	
	item_list.append(make_item(
		"Low Blow Scroll",
		1500,
		false,
		{
			"light_down": 0.6
		},
		0,
		false,
		[
			"Adds a 0.6 multiplier to your light down attacks."
		]
	))
	
	item_list.append(make_item(
		"Brass Knuckles",
		1000,
		false,
		{
			"light": 0.2
		},
		2,
		false,
		[
			"Adds a 0.2 multiplier to your light attacks."
		]
	))
	
	item_list.append(make_item(
		"Bird Punching Glasses",
		900,
		true,
		{
			"light_up": 0.2,
			"heavy_up": 0.2
		},
		3,
		false,
		[
			"Adds a 0.2 multiplier to your light up and heavy up attacks."
		]
	))

	item_list.append(make_item(
		"Danger Short",
		1900,
		false,
		{
			"light_side": 0.3,
			"heavy_side": 0.3
		},
		20,
		false,
		[
			"Adds a 0.3 multiplier to your light and heavy side attacks."
		]
	))
	
	item_list.append(make_item(
		"High Kick Scroll",
		2200,
		false,
		{
			"heavy_up": 0.6
		},
		5,
		false,
		[
			"Adds a 0.6 multiplier to your heavy up attack."
		]
	))
	
	item_list.append(make_item(
		"Heel Slam Scroll",
		1600,
		false,
		{
			"heavy_down": 0.3
		},
		6,
		false,
		[
			"Adds a 0.3 multiplier to your heavy down attack."
		]
	))
	
	item_list.append(make_item(
		"Leg Sweep Scroll",
		800,
		false,
		{
			"light_down": 0.2
		},
		0,
		false,
		[
			"Adds a 0.2 multiplier to your light down attacks."
		]
	))
	
	item_list.append(make_item(
		"Penny Pouch",
		1500,
		false,
		{
			"money": 0.2
		},
		7,
		false,
		[
			"Adds 0.2 to your money multiplier."
		]
	))
	
	item_list.append(make_item(
		"Piggy Bank",
		5500,
		true,
		{
			"money": 1
		},
		8,
		false,
		[
			"Adds 1 to your money multiplier"
		]
	))
	
	item_list.append(make_item(
		"Steroids",
		3000,
		false,
		{
			"light": 1,
			"heavy": 1
		},
		9,
		false,
		[
			"Adds 1 to your light and heavy attack multiplier"
		]
	))
	
	item_list.append(make_item(
		"A Big Meal",
		2000,
		true,
		{
			"heavy": 0.5
		},
		10,
		false,
		[
			"Adds a 0.5 multiplier to your heavy attacks"
		]
	))
	
	item_list.append(make_item(
		"Anti-Air Jordans",
		2000,
		false,
		{
			"light_air": 0.4,
			"heavy_air": 0.4
		},
		11,
		false,
		[
			"Extra stylish, adds 0.4 to your light air and heavy air attack multiplier"
		]
	))
	
	item_list.append(make_item(
		"Balloon Pack",
		1200,
		true,
		{
			"light_air": 0.3
		},
		12,
		false,
		[
			"Adds 0.3 multiplier to light air attacks"
		]
	))
	
	item_list.append(make_item(
		"Smelly Soles",
		2100,
		false,
		{
			"heavy_side": 0.5
		},
		13,
		false,
		[
			"Stinky, adds a 0.5 multiplier to heavy side attacks"
		]
	))
	
	item_list.append(make_item(
		"Shoulder Pads",
		1500,
		false,
		{
			"light_side": 0.5
		},
		14,
		false,
		[
			"Adds a 0.5 multiplier to the light side attacks"
		]
	))
	
	item_list.append(make_item(
		"Floaty Fist",
		1600,
		false,
		{
			"light_neutral": 0.4
		},
		15,
		false,
		[
			"Adds a 0.4 multiplier to light neutral attacks"
		]
	))
	
	item_list.append(make_item(
		"Cleats",
		2800,
		false,
		{
			"light_down": 0.6,
			"heavy_down": 0.6
		},
		11,
		false,
		[
			"Adds 0.6 to the light down and heavy down multiplier attacks"
		]
	))
	
	item_list.append(make_item(
		"Hammer Fist",
		1600,
		false,
		{
			"heavy_air": 0.3
		},
		16,
		false,
		[
			"Adds a 0.3 multiplier to heavy air attacks"
		]
	))
	
	item_list.append(make_item(
		"Ski Mask",
		3000,
		false,
		{
			"money": 0.5
		},
		17,
		false,
		[
			"Adds a 0.5 multiplier to money"
		]
	))
	
	item_list.append(make_item(
		"Spring Fist",
		2000,
		false,
		{
			"heavy_neutral": 0.5
		},
		19,
		false,
		[
			"Adds a 0.5 multiplier to heavy neutral attacks"
		]
	))
	
	item_list.append(make_item(
		"Unfair Gloves",
		2800,
		true,
		{
			"light_neutral": 0.5,
			"heavy_neutral": 0.5
		},
		22,
		false,
		[
			"Adds 0.5 to your light neutral and heavy neutral attack multiplier"
		]
	))
	
	item_list.append(make_item(
		"More Hands",
		6000,
		false,
		{
			"light_neutral": 0.5,
			"heavy_neutral": 0.5
		},
		21,
		false,
		[
			"Allows you to equip 1 more item and adds 0.5 to your light neutral and heavy neutral attack multiplier."
		],
		{
			"moreequips"	:	1
		}
	))
	
	item_list.append(make_item(
		"More Unfair Gloves",
		8500,
		false,
		{
			"light_neutral": 0.7,
			"heavy_neutral": 0.7
		},
		22,
		false,
		[
			"Allows you to equip 2 more items, and adds 0.7 to your light neutral and heavy neutral attack multiplier."
		],
		{
			"moreequips"	:	2
		}
	))
	
	#add a new line for the changes
