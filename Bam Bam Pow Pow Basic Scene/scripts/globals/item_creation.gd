extends Node

var item_list = []
@onready var itemMax = 0;

enum MULTTYPE {
	MONEY,
	BASE,
	DIRECTION,
	SPECIFIC
}

func make_item(name, price, owned, effects: Dictionary, sprite_index) -> Dictionary:
	var item: Dictionary = {
		"name" 		: name,
		"price" 	: price,
		"owned" 	: owned,
		"effects" 	: {},
		"sprite" 	: sprite_index
	}
	return item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_list.append(make_item(
		"Uppercut Scroll",
		500,
		false,
		{
			"light_up": 0.5,
			"heavy_up": 0.5
		},
		4
	))
	itemMax += 1;
	
	item_list.append(make_item(
		"Low Blow Scroll",
		500,
		false,
		{
			"light_down": 0.6
		},
		4
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Brass Knuckles",
		700,
		false,
		{
			"light": 0.2
		},
		12
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Bird Punching Glasses",
		700,
		false,
		{
			"light_up": 0.2,
			"heavy_up": 0.2
		},
		11
	))
	
	itemMax += 1;

	item_list.append(make_item(
		"Danger Short",
		700,
		false,
		{
			"light_side": 0.3,
			"heavy_side": 0.3
		},
		9
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"High Kick Scroll",
		500,
		false,
		{
			"heavy_up": 0.6
		},
		5
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Heel Slam Scroll",
		500,
		false,
		{
			"heavy_down": 0.3
		},
		5
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Leg Sweep Scroll",
		500,
		false,
		{
			"light_down": 0.2
		},
		5
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Penny Pouch",
		200,
		false,
		{
			"money": 0.2
		},
		16
	))
	
	itemMax += 1;
	
	item_list.append(make_item(
		"Piggy Bank",
		500,
		false,
		{
			"money": 1
		},
		16
	))
	
	itemMax += 1;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
