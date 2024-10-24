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
func make_item(name, price, owned, effects: Dictionary, sprite_index, equipped) -> Dictionary:
	var item: Dictionary = {
		"name" 		: name,
		"price" 	: price,
		"owned" 	: owned,
		"effects" 	: effects,
		"sprite" 	: sprite_index,
		"equipped"	: equipped
	}
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
		4,
		false
	))
	itemMax += 1;
	
	item_list.append(make_item(
		"Low Blow Scroll",
		1200,
		false,
		{
			"light_down": 0.6
		},
		4,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Brass Knuckles",
		400,
		false,
		{
			"light": 0.2
		},
		0,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Bird Punching Glasses",
		600,
		true,
		{
			"light_up": 0.2,
			"heavy_up": 0.2
		},
		11,
		false
	))
	
	itemMax += 1;

	item_list.append(make_item(
		"Danger Short",
		900,
		false,
		{
			"light_side": 0.3,
			"heavy_side": 0.3
		},
		8,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"High Kick Scroll",
		1200,
		false,
		{
			"heavy_up": 0.6
		},
		5,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Heel Slam Scroll",
		600,
		false,
		{
			"heavy_down": 0.3
		},
		5,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Leg Sweep Scroll",
		400,
		false,
		{
			"light_down": 0.2
		},
		4,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		400,
		false,
		{
			"money": 0.2
		},
		16,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		2000,
		true,
		{
			"money": 1
		},
		16,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Steroids",
		3000,
		false,
		{
			"light": 1,
			"heavy": 1
		},
		3,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"A Big Meal",
		1000,
		true,
		{
			"heavy": 0.5
		},
		1,
		false
	))
	
	itemMax += 1;
	
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
	
	itemMax += 1;
	
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
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Smelly Soles",
		1000,
		false,
		{
			"heavy_side": 0.5
		},
		5,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Shoulder Pads",
		1000,
		false,
		{
			"light_side": 0.5
		},
		4,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Floaty Fist",
		800,
		false,
		{
			"light_neutral": 0.4
		},
		4,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Cleats",
		1800,
		false,
		{
			"light_down": 0.6,
			"heavy_down": 0.6
		},
		9,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Hammer Fist",
		600,
		false,
		{
			"heavy_air": 0.3
		},
		13,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Ski Mask",
		1000,
		false,
		{
			"money": 0.5
		},
		16,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Spring Fist",
		1000,
		false,
		{
			"heavy_neutral": 0.5
		},
		5,
		false
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Enlightened Centrist",
		1500,
		true,
		{
			"light_neutral": 0.5,
			"heavy_neutral": 0.5
		},
		17,
		false
	))
	
	itemMax += 1;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
