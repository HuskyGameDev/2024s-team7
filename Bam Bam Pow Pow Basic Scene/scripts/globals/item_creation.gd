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
		"sprite" 	: sprite_index,
		"equipped"	: equipped,
		"descript"	: descript,
		"on_buy"	: on_buy
	}
	itemMax += 1
	return item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_list.append(make_item(
		"Uppercut Scroll",
		1000,
		true,
		{
			"light_up": 0.5
		},
		1,
		false,
		[
			"Adds 0.5 to your light up attack multiplier."	
		]
	))
	
	item_list.append(make_item(
		"Low Blow Scroll",
		1200,
		false,
		{
			"light_down": 0.6
		},
		0,
		false,
		[
			"Adds 0.6 to your light down multiplier."
		]
	))
	
	item_list.append(make_item(
		"Brass Knuckles",
		400,
		false,
		{
			"light": 0.2
		},
		2,
		false,
		[
			"Adds 0.2 to your light attacks mutliplier."
		]
	))
	
	item_list.append(make_item(
		"Bird Punching Glasses",
		600,
		true,
		{
			"light_up": 0.2,
			"heavy_up": 0.2
		},
		3,
		false,
		[
			"Adds 0.2 to your light and heavy up attacks."
		]
	))

	item_list.append(make_item(
		"Danger Short",
		900,
		false,
		{
			"light_side": 0.3,
			"heavy_side": 0.3
		},
		20,
		false,
		[
			"Adds 0.3 to your light and heavy side attacks."
		]
	))
	
	item_list.append(make_item(
		"High Kick Scroll",
		1200,
		false,
		{
			"heavy_up": 0.6
		},
		5,
		false,
		[
			"Adds 0.6 to your heavy up attack."
		]
	))
	
	item_list.append(make_item(
		"Heel Slam Scroll",
		600,
		false,
		{
			"heavy_down": 0.3
		},
		6,
		false,
		[
			"Adds 0.3 to your heavy down attack."
		]
	))
	
	item_list.append(make_item(
		"Leg Sweep Scroll",
		400,
		false,
		{
			"light_down": 0.2
		},
		0,
		false,
		[
			"Adds 0.2 to your light down multiplier."
		]
	))
	
	item_list.append(make_item(
		"Penny Pouch",
		400,
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
		2000,
		true,
		{
			"money": 1
		},
		8,
		false
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
		false
	))
	
	item_list.append(make_item(
		"A Big Meal",
		1000,
		true,
		{
			"heavy": 0.5
		},
		10,
		false
	))
	
	item_list.append(make_item(
		"Anti-Air Jordans",
		1200,
		false,
		{
			"light_air": 0.4,
			"heavy_air": 0.4
		},
		11,
		false
	))
	
	item_list.append(make_item(
		"Balloon Pack",
		600,
		true,
		{
			"light_air": 0.3
		},
		12,
		false
	))
	
	item_list.append(make_item(
		"Smelly Soles",
		1000,
		false,
		{
			"heavy_side": 0.5
		},
		13,
		false
	))
	
	item_list.append(make_item(
		"Shoulder Pads",
		1000,
		false,
		{
			"light_side": 0.5
		},
		14,
		false
	))
	
	item_list.append(make_item(
		"Floaty Fist",
		800,
		false,
		{
			"light_neutral": 0.4
		},
		15,
		false
	))
	
	item_list.append(make_item(
		"Cleats",
		1800,
		false,
		{
			"light_down": 0.6,
			"heavy_down": 0.6
		},
		11,
		false
	))
	
	item_list.append(make_item(
		"Hammer Fist",
		600,
		false,
		{
			"heavy_air": 0.3
		},
		16,
		false
	))
	
	item_list.append(make_item(
		"Ski Mask",
		1000,
		false,
		{
			"money": 0.5
		},
		17,
		false
	))
	
	item_list.append(make_item(
		"Spring Fist",
		1000,
		false,
		{
			"heavy_neutral": 0.5
		},
		19,
		false
	))
	
	item_list.append(make_item(
		"Unfair Gloves",
		2500,
		true,
		{
			"light_neutral": 0.5,
			"heavy_neutral": 0.5
		},
		22,
		false
	))
	
	item_list.append(make_item(
		"More Hands",
		3000,
		false,
		{
			"light_neutral": 0.5,
			"heavy_neutral": 0.5
		},
		21,
		false,
		[
			"Allows you to equip 1 more item."
		],
		{
			"moreequips"	:	1
		}
	))
	
	item_list.append(make_item(
		"More Unfair Gloves",
		4500,
		false,
		{
			"light_neutral": 0.7,
			"heavy_neutral": 0.7
		},
		22,
		false,
		[
			"Allows you to equip 2 more item."
		],
		{
			"moreequips"	:	2
		}
	))
