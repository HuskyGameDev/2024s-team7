extends Node

class_name fight_details

var opponents_list = []			# List of opponent detail dictionaries in order of the fights
var opponents_progression = 0	# Which opponent fight player has made it to

func make_opponent(name: String, health: int, sprite_path: String, floor_path: String,
			   background_path: String, time: int, defeated: bool, defeatable: bool,
			   weakness: String, speech: Array[String]=["No Words"]) -> Dictionary:
	var opponent: Dictionary = {
		"name":			name,
		"health":		health,
		"sprite_path":	sprite_path,
		"floor_path":	floor_path,
		"background_path": background_path,
		"time":			time,
		"defeated": 		defeated,
		"defeatable":	defeatable,
		"weakness":		weakness,
		"speech"	: 		speech
	}
	return opponent

# Called when the node enters the scene tree for the first time.
func _ready():
	opponents_list.append(make_opponent(
		"Bat",
		1000,
		"res://resources/sprites/Sandbag_Sprites_PLAYTEST.png",
		"res://Assets/tile-sakura .PNG",
		"res://Assets/bg-sakura.PNG",
		30,
		false,
		false,
		"",
		[
			"...", "It cannot speak. It is a sandbag."
		]
	))
	
	opponents_list.append(make_opponent(
		"Bat",
		1000,
		"res://resources/sprites/Shop_sprites.png",
		"res://Assets/icon.svg",
		"res://Assets/backtemp.png",
		30,
		false,
		true,
		"light",
		[
			"Hello! Loser >:D"
		]
	))
	
	var currentOpponent = opponents_list[opponents_progression]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
